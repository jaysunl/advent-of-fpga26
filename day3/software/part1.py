import sys
from pathlib import Path


def max_bank_joltage(line: str) -> int:
    digits = [ord(ch) - 48 for ch in line.strip()]
    if len(digits) < 2:
        return 0
    max_val = 0
    max_right = -1
    for idx in range(len(digits) - 1, -1, -1):
        d = digits[idx]
        if max_right != -1:
            candidate = d * 10 + max_right
            if candidate > max_val:
                max_val = candidate
        if d > max_right:
            max_right = d
    return max_val


def main():
    if len(sys.argv) != 2:
        print("Usage: python part1.py <input_file>")
        sys.exit(1)
    
    input_path = Path(sys.argv[1])
    total = 0
    for line in input_path.read_text().splitlines():
        if not line.strip():
            continue
        total += max_bank_joltage(line)
    print(total)


if __name__ == "__main__":
    main()
