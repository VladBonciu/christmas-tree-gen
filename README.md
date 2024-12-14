# Christmas Tree Generator in Assembly 🎄


A small coding project I made to enhance my coding skills in assembly on the _**16-bit Intel 80286** processor._

## How can I run this?

The way I coded and tested this script was through the [MASM/TASM](https://marketplace.visualstudio.com/items?itemName=xsro.masm-tasm) plugin inside of Visual Studio Code.

After installing the plugin you can right click on the code snippet that you wish to run and select the **‘Run ASM code’** option.

## How do I create my own tree?

Every value thats introduced (which has to be a number from 1-9 in order for the program to work) represents the witdth of a line of the tree. This means you can build your own desired shape based on the inputs provided.

Basically you're building your tree from the bottom up.

**Here's an example of an input form:** 133221
_(A more complex example would be:  322239888777666554433322211)_

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/ExampleImage.png)

## How did I make this?

This is a surface level explanation of how the program works.

### 1) Reading values from the keyboard
The program is reading characters from the keyboard until Enter is met. The read values are registered and converted from ASCII to the value of that character. The input is then multiplied by 2 in order to be able to center it. The value is then pushed onto the stack.
### 2) Generating lines based on the input values
After reading the input values it starts generating the lines based on the values on the stack, until the read value is 0. (which i pushed on the stack before reding the fist character) The lines are offset based on their legth in order to center all the rows.

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/LineDrawn.png)

The color of the line is automatically changed when the previous line length is bigger than the line that is currently drawn.

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/ColorChanged.png)
### 3) Generating christmas globes based on the input values
The christmas globes are generated using the same values previously provided on the stack. Their initial position is that of the first pixel of the line.

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/DrawingGlobes.png)

### 4) Offseting those values in order for them to appear random
The globe positions are offset from the first pixel of the row by taking a random value from the stack (which is obtained by an initial seed being added to the base pointers position, from which a supposedly random value is extracted), squaring it, and then dividing it by the length of the current line. The remainder of the division is the offset of the initial position. After all that the random seed is incremented for a different outcome on the next row.

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/OffsettingGlobes.png)

## Examples

Here are some examples generated with the program: 

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/Ex3.png)
![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/Ex2.png)
![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/Images/Ex1.png)


## License

This project is under the [CC0 License](https://creativecommons.org/public-domain/cc0/), so have fun with it!
