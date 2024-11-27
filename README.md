


# ICS3203-CAT2-Assembly-MuteiStephenSolovea-150889



## Array Reversal Program

### Overview
This program takes 5 integers from the user, stores them in an array, and then reverses the array in place. After reversing the array, it prints the reversed array to the console. The program uses basic system calls for reading input, writing output, and handling memory manipulation.

### Compilation and Execution
1. Compile the code using NASM and link it using the `ld` linker:
   ```bash
   nasm -f elf64 array_reversal.asm -o array_reversal.o
   ld array_reversal.o -o array_reversal
   ```
2. Run the program:
   ```bash
   ./array_reversal
   ```

### Insights and Challenges

### Array Reversal Process
The reversal of the array is done in-place, meaning that the program swaps the elements in the array without using additional memory for another array. The steps in the reversal are as follows:

1. **Pointer Setup**:
   - `lea rsi, [arr]`: Load the address of the start of the array into `rsi`.
   - `lea rdi, [arr + 16]`: Load the address of the end of the array into `rdi` (since we have 5 integers and each integer is 4 bytes, the end address is `arr + 4*4 = arr + 16`).

2. **Loop and Swap**:
   - The reversal is performed by comparing the elements at the start and the end of the array.
   - The loop runs until half of the array has been processed (`rcx` is initialized to 2 because there are 5 elements, and swapping is done between the first and last elements, the second and second-to-last, etc.).
   - Inside the loop:
     - `mov eax, [rsi]`: Load the value at the start of the array into the `eax` register.
     - `mov ebx, [rdi]`: Load the value at the end of the array into the `ebx` register.
     - `mov [rsi], ebx`: Write the value from the end into the start position.
     - `mov [rdi], eax`: Write the value from the start into the end position.
   - After each swap:
     - `add rsi, 4`: Move the start pointer forward by 4 bytes (size of one integer).
     - `sub rdi, 4`: Move the end pointer backward by 4 bytes.
   - The `loop .reverse_loop` instruction decrements `rcx` and repeats until all required swaps are completed.

3. **Challenges in Memory Handling**:
   - The primary challenge in memory manipulation here is ensuring that the correct positions are being accessed and modified. Since we are working with raw memory (using addresses directly), we need to be careful about pointer arithmetic to avoid overwriting or accessing invalid memory locations.
   - Memory manipulation also involves careful management of registers, ensuring that no important data is lost when performing the swap operations.
   - Direct manipulation of the memory pointers (`rsi` and `rdi`) can be error-prone, especially when using base-10 values in the `lea` instruction for memory offsets.

4. **Edge Case Handling**:
   - The program assumes that the user will provide exactly 5 integers. If the user provides fewer or more integers, the program may not work correctly.
   - The code uses a fixed length for both the prompt and input size. Proper validation of user input (like checking if the number of integers is exactly 5) would be required for a more robust solution.

### Conclusion
The array reversal process, while straightforward, required careful pointer manipulation and register handling to ensure the correct swapping of elements. Working directly with memory in assembly allows for more efficient solutions but also comes with risks of overwriting memory or causing segmentation faults if not handled properly. By reversing the array in place, we saved memory but had to be cautious in handling pointer movements and swap operations to avoid errors.
---










## Factorial Program

### Overview
This program calculates the factorial of a user-provided number. It includes input validation, error handling, and ensures proper handling of the stack during recursive factorial calculation. The program uses system calls to read user input, print messages, and perform calculations. 

### Compilation and Execution
1. Compile the code using NASM and link it using the `ld` linker:
   ```bash
   nasm -f elf64 factorial_subroutine.asm -o factorial_subroutine.o
   ld factorial_subroutine.o -o factorial_subroutine
   ```
2. Run the program:
   ```bash
   ./factorial_subroutine
   ```

### Insights and Challenges

### Register Management and Stack Preservation

When performing complex tasks like recursive function calls, preserving and restoring register values is critical to avoid overwriting or losing data. In this program, registers are carefully managed, especially during the recursive calls in the `factorial` function.

#### 1. **Recursive Factorial Calculation**:
The factorial calculation is done recursively. Each recursive call needs to preserve the values in registers, particularly the input value (`rdi`), to avoid overwriting the value before the multiplication step.

- **Preserving `rdi` (input value for factorial)**:
  - Before making the recursive call in the `factorial` function, the current value of `rdi` is pushed onto the stack to preserve it for the next step. This is necessary because the value of `rdi` is overwritten when the function is called recursively.
  - `push rdi`: This instruction saves the current value of `rdi` on the stack, ensuring that the value is not lost after the recursive call.

- **Restoring `rdi`**:
  - After the recursive call finishes and the value of `rax` (the result of the recursive call) is multiplied by `rdi`, the original value of `rdi` needs to be restored.
  - `pop rdi`: This instruction restores the value of `rdi` from the stack, allowing the program to continue with the correct value for the next computation.

- **Overflow check**:
  - The `jo _error` instruction checks for overflow after multiplying the result (`rax`) by the current value of `rdi`. If an overflow occurs (which is a possible issue when calculating large factorials), the program jumps to the error handling section.

#### 2. **Base Case**:
- The base case of the recursion (when `rdi <= 1`) directly sets `rax` to 1, as the factorial of 1 is 1. This value is then returned, allowing the recursive calls to unwind correctly.

#### 3. **Input Conversion**:
- **Preserving `rax` during string-to-integer conversion**:
  - In the `string_to_int` function, the `rax` register is used to accumulate the integer value as characters are parsed. Since `rax` is needed for calculations, it must be preserved through other operations.
  - Each time a character is processed, `rax` is updated by multiplying the current value by 10 and adding the integer value of the character. No explicit preservation of `rax` is needed here since the conversion is straightforward and does not involve recursive calls or additional function calls.

#### 4. **Factorial Output**:
- After calculating the factorial, the result (`rax`) is converted to a string using the `int_to_ascii` function. During this conversion, the `rdx` register is used to hold the remainder from the division, and `rax` is divided by 10 to extract each digit. Registers are carefully managed to ensure the ASCII string is correctly formed.

### Example Stack Flow (Factorial Calculation)
1. The user enters a number (e.g., `5`).
2. The program converts the input string into an integer.
3. The factorial function is called with the value of the number (`rdi = 5`):
   - The current value of `rdi` (5) is pushed onto the stack: `push rdi`.
   - `rdi` is decremented to 4 (`dec rdi`), and a recursive call is made.
   - The process repeats until `rdi <= 1` (base case).
   - When the base case is reached, `rax` is set to 1.
   - The recursive calls start returning, multiplying the returned result by the value of `rdi`:
     - Before each multiplication, `rdi` is restored from the stack: `pop rdi`.
   - The result is then returned and converted to ASCII for output.

### Conclusion
Managing register values and stack preservation is crucial in recursive programs like this one. In this program, the stack is used to store the value of `rdi` during each recursive call, ensuring that the original input value is preserved. This method allows the program to perform the factorial calculation correctly while maintaining the integrity of register values, especially across multiple recursive function calls.
---





## Number Sign Detection Program

### Overview
This assembly program prompts the user to enter a single digit (0-9), processes the input, and then prints a message indicating whether the number is positive, negative, or zero. The program uses simple system calls for input/output operations and performs conditional checks to determine the sign of the number. 

### Compilation and Execution
1. Compile the program using NASM and link it with `ld`:
   ```bash
   nasm -f elf32 number_classification.asm -o number_classification.o
   ld -m elf_i386 -s -o number_classififcation number_classification.o
   ```
2. Run the program:
   ```bash
   ./number_classification
   ```

### Insights and Challenges

### Choice of Jump Instructions and Their Impact on Program Flow

The program makes use of several jump instructions (`je`, `jl`, `jmp`) to control the flow based on the comparison between the input value and zero. These conditional jump instructions are critical for handling different program paths depending on the user's input.

### 1. **Handling Zero (je instruction)**:
   - After converting the user input from ASCII to an integer using `sub al, '0'`, we need to check if the number is zero.
   - The `cmp al, 0` instruction compares the value in the `AL` register (which holds the user's input, now converted to an integer) with 0.
   - The `je .is_zero` jump instruction is used here to check if the number is exactly zero. If the comparison result indicates equality (i.e., `AL` equals 0), the program will jump to the `.is_zero` label, where it will print the "The number is ZERO" message.
   - **Why `je`?**: The `je` instruction is used because it directly checks if the comparison between `AL` and 0 results in equality. It simplifies the logic and avoids unnecessary branching, improving readability and flow.

### 2. **Handling Negative Numbers (jl instruction)**:
   - The next step is to check if the number is negative. This is done by checking if the value in `AL` is less than zero. 
   - Since the input is a single digit (0-9) and is converted to a positive integer (or zero), this check doesn't strictly apply here because the user cannot input negative values directly. However, for the sake of clarity, we include the check for negative numbers using `jl .is_negative`.
   - The `cmp al, 0` instruction again compares the value of `AL` with 0. If the result shows that `AL` is less than 0 (which in this case should never happen for valid input), the program will jump to `.is_negative` to output the "The number is NEGATIVE" message.
   - **Why `jl`?**: The `jl` instruction is used to jump if the number is less than zero. In the context of this simple program, this instruction is superfluous for valid input (as only positive numbers or zero are possible), but it is useful as a placeholder for any future expansion or for educational purposes, where negative input might be handled differently.

### 3. **Handling Positive Numbers (Unconditional jump with `jmp`)**:
   - If the number is neither zero nor negative, it must be positive. Once we have eliminated the zero and negative cases, we jump to the `.is_positive` label, where the message "The number is POSITIVE" is printed.
   - The unconditional jump (`jmp .display_result`) is used here to transfer control directly to the `display_result` section, where the appropriate message is printed. 
   - **Why `jmp`?**: The `jmp` instruction is used because, once we know that the input is positive, we simply want to display the result without needing to check any further conditions. The jump allows us to skip the rest of the logic and move directly to the message display code.

### 4. **Displaying the Result**:
   - The `display_result` section is used to print the result message based on which number category (positive, negative, or zero) the input falls into.
   - The system call `int 0x80` with the appropriate parameters (`eax = 4` for `write`, `ebx = 1` for `stdout`, `ecx` pointing to the message, and `edx` the length of the message) is used to output the corresponding message.

### 5. **Exit**:
   - After printing the result message, the program exits cleanly with the `exit` syscall. `xor ebx, ebx` ensures that the exit code is `0` (indicating successful execution).
   - `int 0x80` is used again to make the syscall.

## Full Program Flow
1. The program starts by displaying the prompt message asking the user to enter a number.
2. It reads a single character from the user and converts it from ASCII to an integer.
3. The program compares the input value with zero using `cmp al, 0`:
   - If the number is zero, it jumps to `.is_zero` and prints "The number is ZERO".
   - If the number is negative, it would jump to `.is_negative` (though in this simple program, negative numbers are not valid).
   - If the number is positive, it proceeds to `.is_positive` and prints "The number is POSITIVE".
4. After displaying the appropriate message, the program exits cleanly.

## Conclusion
The use of conditional jumps (`je`, `jl`) allows for clear, concise branching based on the input value, ensuring that the program handles different scenarios (positive, negative, zero) efficiently. The `jmp` instruction ensures that once a valid category is determined, the program can skip unnecessary checks and move directly to the result display section. These decisions make the program flow simple and easy to understand.


### Explanation of Jump Instructions:

1. **`je`** (Jump if Equal) is used to check if the input value is zero. It ensures that the program takes the correct path when the input is zero without unnecessary checks.
2. **`jl`** (Jump if Less) is used to detect if the number is less than zero. Although it doesn't apply to valid inputs in this case, it’s used to illustrate how one might handle negative input in more complex scenarios.
3. **`jmp`** (Unconditional Jump) is used to move directly to the section that displays the result message when the input is positive, skipping unnecessary checks.

This structured flow of the program helps ensure that the logic is straightforward and avoids redundant operations. Let me know if you need further clarifications!
---




## Sensor Simulation Program

### Overview
This program simulates a basic sensor system where the sensor value determines whether a motor should be started or stopped and whether an alarm should be activated. The program checks the sensor value against predefined thresholds and updates the motor and alarm status accordingly. It then displays the statuses of both the motor and the alarm.

### Compilation and Execution
1. Compile the code using the NASM assembler and link it using the `ld` linker:
   ```bash
   nasm -f elf64 sensor_simulation.asm -o sensor_simulation.o
   ld sensor_simulation.o -o sensor_simulation
   ```
2. Run the program:
   ```bash
   ./sensor_simulation
   ```

### Insights and Challenges
- **Sensor Input and Conditional Actions**:  
  - The program uses a predefined sensor value (`sensor_val`) which can be modified to simulate different sensor readings.
  - The sensor value is compared to certain thresholds using the `cmp` instruction:
    - If the sensor value is greater than or equal to 90 (`jge .activate_alarm`), it triggers the alarm.
    - If the sensor value is greater than or equal to 50 but less than 90, it stops the motor (`jge .stop_motor`).
    - If the sensor value is less than 50, the motor is started (`jmp .start_motor`).

- **Memory Manipulation**:
  - The status of the motor and alarm are stored in memory locations defined as `motor_status` and `alarm_status`. These are byte-sized variables:
    - `motor_status` is set to 1 (on) or 0 (off) depending on the sensor value.
    - `alarm_status` is set to 1 (active) or 0 (inactive) based on the sensor threshold.
  - The program manipulates these memory locations to reflect the actions taken (starting or stopping the motor, activating or deactivating the alarm).

- **Displaying the Status**:
  - Once the appropriate action is taken, the program prints messages to standard output reflecting the motor and alarm statuses. This is done using system calls with the `write` syscall (`mov rax, 1`), where messages are determined based on the current values of `motor_status` and `alarm_status`.
  - Conditional jumps (`je`) are used to determine whether to display "Motor: ON" or "Motor: OFF", and whether to show "Alarm: ACTIVE" or "Alarm: INACTIVE".

- **Challenges**:
  - Ensuring proper updates to the motor and alarm status based on the sensor reading was crucial, particularly managing memory locations that store the state of each component.
  - Managing conditional jumps correctly allowed the program to handle different sensor readings and respond accordingly, without redundant checks or unnecessary code execution.
---



