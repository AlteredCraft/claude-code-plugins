#!/bin/bash
#
# Ralph One-Shot Script
#
# Runs Claude Code once to execute the next task from a spec folder.
# Output streams directly to terminal for HITL observation.
#
# Usage:
#   ./ralph-one.sh              # Interactive: list specs, choose one
#   ./ralph-one.sh task-name    # Run specific task from specs/task-name/
#
# Prerequisites:
#   - BUILD_PROMPT.md in current directory
#   - specs/[task-name]/ directory with IMPLEMENTATION_PLAN.md, AGENTS.md, BACKPRESSURE.md
#   - Claude CLI installed and authenticated
#
# Safety:
#   - Uses --dangerously-skip-permissions (required for autonomy)
#   - Run in sandboxed environment (Docker recommended)
#
# For looped execution, use ralph.sh instead.
#
# Based on: https://github.com/ghuntley/how-to-ralph-wiggum
#

set -e

PROMPT_FILE="BUILD_PROMPT.md"
SPEC_DIR=""

# Verify prompt exists
if [[ ! -f "$PROMPT_FILE" ]]; then
    echo "Error: $PROMPT_FILE not found in current directory"
    exit 1
fi

# Verify specs directory exists
if [[ ! -d "specs" ]]; then
    echo "Error: specs/ directory not found"
    echo "Run /ralph-method first to generate specs."
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
if [[ -n "$1" && -d "specs/$1" ]]; then
    # First arg is a valid spec name
    SPEC_DIR="specs/$1"
fi

# If no spec selected, show interactive menu
if [[ -z "$SPEC_DIR" ]]; then
    SPECS=($(list_specs))

    if [[ ${#SPECS[@]} -eq 0 ]]; then
        echo "Error: No valid specs found in specs/"
        echo "Each spec needs an IMPLEMENTATION_PLAN.md file."
        echo "Run /ralph-method first to generate specs."
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
echo "  Ralph One-Shot"
echo "=========================================="
echo "  Task: $TASK_NAME"
echo "  Specs: $SPEC_DIR/"
echo "=========================================="
echo ""
echo "⚠️  This runs with --dangerously-skip-permissions"
echo "⚠️  Recommended: Run in sandboxed environment"
echo ""

# Run Claude with the prompt - output streams directly to terminal
RALPH_SPEC_DIR="$SPEC_DIR" claude -p --dangerously-skip-permissions --verbose < "$PROMPT_FILE"

# Clean up task selection file
rm -f .ralph-task
