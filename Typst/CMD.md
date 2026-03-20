Here is a detailed table of very commonly used operations in the Windows Command Prompt (cmd.exe). These are selected specifically for your workflow: managing folders for Python projects, running your custom Python installation at `C:\Users\hexio\AppData\Local\Python\pythoncore-3.14-64\python.exe`, installing libraries for scientific plotting (e.g., matplotlib, numpy, pandas, scipy, seaborn), and working with JupyterLab / Jupyter Notebook.

All commands are shown with their abbreviated form (as typed in cmd), the full English name, a clear description, example usage tailored to your setup, and relevance to your Python scientific graphics + Jupyter work.

| Command                | Full English Name               | Description                                                                                   | Example Usage (copy-paste ready)                                         | Relevance to Python Scientific Plotting and Jupyter                                    |
| ---------------------- | ------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| cd                     | Change Directory                | Changes the current working folder                                                            | cd C:\Users\hexio\projects\scientific_plots                              | Go to your project folder before running scripts or notebooks                          |
| dir                    | Directory Listing               | Lists all files and subfolders in the current directory                                       | dir                                                                      | Quickly check for .py files, .ipynb notebooks, or output images                        |
| mkdir                  | Make Directory                  | Creates a new folder                                                                          | mkdir my_plot_project                                                    | Organize folders for different scientific plotting experiments                         |
| rmdir /s /q            | Remove Directory (force)        | Deletes a folder and all its contents (use carefully)                                         | rmdir /s /q old_project                                                  | Clean up finished or test projects                                                     |
| cls                    | Clear Screen                    | Clears everything on the Command Prompt screen                                                | cls                                                                      | Keep the screen clean when installing packages or running Jupyter                      |
| set PATH=%PATH%;path   | Set Environment Variable (PATH) | Temporarily adds your Python folder to PATH so you can type "python" instead of the full path | set PATH=%PATH%;C:\Users\hexio \AppData\Local\Python \pythoncore-3.14-64 | Makes "python" and "pip" commands work without typing the long path every time         |
| python                 | Python Interpreter              | Runs Python (after adding to PATH)                                                            | python --version<br>python plot_script.py                                | Check version; run .py scripts that create scientific plots with matplotlib            |
| python -m pip          | Python Package Installer (pip)  | Installs, upgrades, or removes Python libraries                                               | python -m pip install numpy matplotlib pandas scipy seaborn jupyterlab   | Install all libraries needed for scientific graphics and Jupyter in one command        |
| python -m venv         | Virtual Environment Creator     | Creates an isolated Python environment                                                        | python -m venv myenv                                                     | Keep plotting libraries separate from system Python (recommended)                      |
| myenv\Scripts\activate | Activate Virtual Environment    | Activates the virtual environment (type after creating it)                                    | myenv\Scripts\activate                                                   | Use this before installing packages or launching Jupyter so everything stays isolated  |
| jupyter lab            | JupyterLab Launcher             | Starts the modern JupyterLab web interface                                                    | jupyter lab                                                              | Open interactive notebooks where you can write code and instantly see scientific plots |
| jupyter notebook       | Jupyter Notebook Launcher       | Starts the classic Jupyter Notebook interface                                                 | jupyter notebook                                                         | Alternative way to run older-style notebooks for plotting                              |
| jupyter nbconvert      | Jupyter Notebook Converter      | Converts notebooks to other formats (HTML, PDF, Python script, etc.)                          | jupyter nbconvert --to html my_plot.ipynb                                | Export finished scientific plots/notebooks to shareable HTML or PDF files              |
| python -m jupyter lab  | JupyterLab via Python module    | Starts JupyterLab using your specific Python (safe fallback)                                  | python -m jupyter lab                                                    | Use this if the plain "jupyter lab" command does not work after installation           |
| -m                     | module                          | In the command python -m jupyter lab, the -m flag stands for "module".                        | python -m jupyter lab                                                    |                                                                                        |
| echo                   | Echo (print or create file)     | Prints text or creates a quick empty file                                                     | echo. > requirements.txt                                                 | Quickly create a requirements.txt file listing your plotting packages                  |
| type                   | Display File Content            | Shows the content of a text file in the terminal                                              | type plot_script.py                                                      | View your Python plotting code without opening an editor                               |

Quick Start Workflow (all in English, using your exact Python path)
1. Open Command Prompt.
2. Add your Python to PATH once per session:  
   `set PATH=%PATH%;C:\Users\hexio\AppData\Local\Python\pythoncore-3.14-64`
3. Navigate to your project:  
   `cd C:\Users\hexio\projects\scientific_plots`
4. Create and activate a virtual environment (recommended):  
   `python -m venv myenv`  
   `myenv\Scripts\activate`
5. Install everything you need for scientific plotting + Jupyter:  
   `python -m pip install numpy matplotlib pandas scipy seaborn jupyterlab`
6. Start working:  
   `jupyter lab`  
   (Your browser will open; create a new notebook and start plotting with matplotlib/seaborn.)

These commands cover 95% of your daily tasks. After you run the PATH command and install the packages once, the workflow becomes very fast. If you ever close the Command Prompt, just repeat the PATH line or add the folder permanently through Windows Settings → System → About → Advanced system settings → Environment Variables.

Let me know if you want more examples for any specific command (e.g., how to run a plotting script or export notebooks).

























