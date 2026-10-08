#Create extract_pose.sh
#!/bin/bash

# Check if required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <docking_log.dlg> <model_number>"
    exit 1
fi

DLG_FILE="$1"
MODEL_NUM="$2"
BASE_NAME="${DLG_FILE%.*}"
PDBQT_OUT="${BASE_NAME}_pose${MODEL_NUM}.pdbqt"
PDB_OUT="${BASE_NAME}_pose${MODEL_NUM}.pdb"

# Check if input file exists
if [ ! -f "$DLG_FILE" ]; then
    echo "Error: File '$DLG_FILE' not found."
    exit 1
fi

echo "Extracting Model $MODEL_NUM from $DLG_FILE..."

# Extract pose using awk
awk -v model="$MODEL_NUM" '
$0 ~ "^DOCKED: MODEL[[:space:]]+" model "$" {flag=1}
flag {
    sub(/^DOCKED: /, "")
    print
}
/^DOCKED: ENDMDL/ && flag {exit}
' "$DLG_FILE" > "$PDBQT_OUT"

echo "Saved: $PDBQT_OUT"

# Convert to PDB using Open Babel if installed
if command -v obabel &> /dev/null; then
    echo "Converting $PDBQT_OUT to $PDB_OUT..."
    obabel "$PDBQT_OUT" -O "$PDB_OUT"
    echo "Converted: $PDB_OUT"
else
    echo "Open Babel (obabel) not found. Skipped .pdb conversion."
fi
