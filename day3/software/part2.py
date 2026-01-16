import sys
from pathlib import Path


def max_bank_joltage(line: str, take: int = 12) -> int:
    digits = line.strip()
    if not digits:
        return 0
    if len(digits) <= take:
        return int(digits)

    remove = len(digits) - take
    stack: list[str] = []
    for ch in digits:
        while remove > 0 and stack and stack[-1] < ch:
            stack.pop()
            remove -= 1
        stack.append(ch)

    if remove > 0:
        stack = stack[:-remove]

    return int("".join(stack[:take]))


def main():
    if len(sys.argv) != 2:
        print("Usage: python part2.py <input_file>")
        sys.exit(1)
    
    input_path = Path(sys.argv[1])
    total = 0
    for line in input_path.read_text().splitlines():
        if not line.strip():
            continue
        total += max_bank_joltage(line, 12)
    print(total)


if __name__ == "__main__":
    main()
