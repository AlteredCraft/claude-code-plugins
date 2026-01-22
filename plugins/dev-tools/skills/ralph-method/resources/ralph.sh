#!/bin/bash
#
# Ralph Loop Script
#
# Runs Claude Code in a loop, feeding BUILD_PROMPT.md until tasks complete.
# Each iteration spawns fresh context - filesystem is memory.
#
# Usage:
#   ./ralph.sh              # Interactive: list specs, choose one, run 15 iterations
#   ./ralph.sh 20           # Interactive selection, 20 max iterations
#   ./ralph.sh task-name    # Run specific task from specs/task-name/
#   ./ralph.sh task-name 20 # Specific task, 20 max iterations
#
# Prerequisites:
#   - BUILD_PROMPT.md in current directory
#   - specs/[task-name]/ directory with IMPLEMENTATION_PLAN.md, AGENTS.md, BACKPRESSURE.md
#   - Claude CLI installed and authenticated
#
# Safety:
#   - Uses --dangerously-skip-permissions (required for autonomy)
#   - Run in sandboxed environment (Docker recommended)
#   - Ctrl+C to stop manually
#
# Based on: https://github.com/ghuntley/how-to-ralph-wiggum
#

set -e

PROMPT_FILE="BUILD_PROMPT.md"
MAX_ITERATIONS=15
SPEC_DIR=""

# Verify prompt exists
if [[ ! -f "$PROMPT_FILE" ]]; then
    echo "Error: $PROMPT_FILE not found in current directory"
    exit 1
fi

# Verify specs directory exists
if [[ ! -d "specs" ]]; then
    echo "Error: specs/ directory not found"
    echo "Run /ralph-task-setup first to generate specs."
    exit 1
fi

# List available specs
list_specs() {
    local specs=()
    for dir in specs/*/; do
        if [[ -f "${dir}IMPLEMENTATION_PLAN.md" ]]; then
            specs+=("$(basename "$dir")")
        fi
    done
    echo "${specs[@]}"
}

# Parse arguments
if [[ "$1" =~ ^[0-9]+$ ]]; then
    # First arg is a number = max iterations, need to select spec
    MAX_ITERATIONS=$1
elif [[ -n "$1" && -d "specs/$1" ]]; then
    # First arg is a valid spec name
    SPEC_DIR="specs/$1"
    if [[ "$2" =~ ^[0-9]+$ ]]; then
        MAX_ITERATIONS=$2
    fi
fi

# If no spec selected, show interactive menu
if [[ -z "$SPEC_DIR" ]]; then
    SPECS=($(list_specs))

    if [[ ${#SPECS[@]} -eq 0 ]]; then
        echo "Error: No valid specs found in specs/"
        echo "Each spec needs an IMPLEMENTATION_PLAN.md file."
        echo "Run /ralph-task-setup first to generate specs."
        exit 1
    fi

    if [[ ${#SPECS[@]} -eq 1 ]]; then
        # Only one spec, use it automatically
        SPEC_DIR="specs/${SPECS[0]}"
        echo "Found one task: ${SPECS[0]}"
    else
        # Multiple specs, prompt for selection
        echo "=========================================="
        echo "  Available Tasks"
        echo "=========================================="
        echo ""

        for i in "${!SPECS[@]}"; do
            echo "  $((i+1))) ${SPECS[$i]}"
        done

        echo ""
        read -p "Select task (1-${#SPECS[@]}): " SELECTION

        if [[ ! "$SELECTION" =~ ^[0-9]+$ ]] || [[ "$SELECTION" -lt 1 ]] || [[ "$SELECTION" -gt ${#SPECS[@]} ]]; then
            echo "Invalid selection"
            exit 1
        fi

        SPEC_DIR="specs/${SPECS[$((SELECTION-1))]}"
    fi
fi

# Verify spec has required files
if [[ ! -f "$SPEC_DIR/IMPLEMENTATION_PLAN.md" ]]; then
    echo "Error: $SPEC_DIR/IMPLEMENTATION_PLAN.md not found"
    exit 1
fi

TASK_NAME=$(basename "$SPEC_DIR")

# Write task selection for BUILD_PROMPT.md to read
echo "$SPEC_DIR" > .ralph-task

echo ""
echo "=========================================="
echo "  Ralph Loop"
echo "=========================================="
echo "  Task: $TASK_NAME"
echo "  Specs: $SPEC_DIR/"
echo "  Max iterations: $MAX_ITERATIONS"
echo "=========================================="
echo ""
echo "⚠️  This runs with --dangerously-skip-permissions"
echo "⚠️  Recommended: Run in sandboxed environment"
echo ""
echo "Starting in 3 seconds... (Ctrl+C to cancel)"
sleep 3

ITERATION=0

while [[ $ITERATION -lt $MAX_ITERATIONS ]]; do
    ITERATION=$((ITERATION + 1))

    echo ""
    echo "=========================================="
    echo "  Iteration $ITERATION / $MAX_ITERATIONS"
    echo "  Task: $TASK_NAME"
    echo "  $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=========================================="
    echo ""

    # Run Claude with the prompt, capture output
    OUTPUT=$(RALPH_SPEC_DIR="$SPEC_DIR" cat "$PROMPT_FILE" | claude -p --dangerously-skip-permissions --verbose)
    EXIT_CODE=$?

    # Display the output
    echo "$OUTPUT"

    if [[ $EXIT_CODE -ne 0 ]]; then
        echo ""
        echo "⚠️  Claude exited with code $EXIT_CODE"
        echo "Continuing to next iteration..."
    fi

    # Check for completion signal
    if echo "$OUTPUT" | grep -q "<result>COMPLETE</result>"; then
        echo ""
        echo "=========================================="
        echo "  All tasks complete!"
        echo "=========================================="
        echo ""
        break
    fi

    # Check for stuck signal
    if echo "$OUTPUT" | grep -q "<result>STUCK</result>"; then
        echo ""
        echo "=========================================="
        echo "  Agent is stuck - human review needed"
        echo "=========================================="
        echo ""
        break
    fi

    # Brief pause between iterations
    sleep 2
done

echo ""
echo "=========================================="
echo "  Loop complete after $ITERATION iterations"
echo "=========================================="
echo ""
echo "Check $SPEC_DIR/IMPLEMENTATION_PLAN.md for progress."

# Clean up task selection file
rm -f .ralph-task
