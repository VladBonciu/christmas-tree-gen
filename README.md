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

![ExampleImage](https://github.com/VladBonciu/christmas-tree-gen/blob/main/ExampleImage.png)

## How did I make this?

### 1) Reading values from the keyboard
### 2) Generating lines based on the input values
### 3) Generating christmas globes based on the input values
### 4) Offseting those values in order for them to appear random

## License

This project is under the [CC0 License](https://creativecommons.org/public-domain/cc0/), so have fun with it!
