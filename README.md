# MPU6050 Module I2C Example with CH552 + WebSerial

This project demonstrates how to read motion data from the MPU6050 sensor using I2C on a CH552 microcontroller, and visualize it in real-time via WebSerial in a browser using Processing.js


## 🧰 Hardware Required

* CH552 development board (Cocket Nova or compatible)
* MPU6050 6-axis sensor (I2C)
* USB connection to host PC

---## 🔧 Compile and Flash Firmware

This example uses an I2C bit-banging implementation and outputs sensor data as JSON via USB-CDC:

```bash
cd examples/I2C/MPU6050
make bin
make flash
```

> Requires SDCC toolchain and `chprog.py` installed.


## 🖥️ Linux Setup for USB CDC Devices

To ensure access to `/dev/ttyACM0` or `/dev/ttyACM1`, configure udev rules:

```bash
sudo nano /etc/udev/rules.d/99-ch552.rules
```

Paste the following (replace with actual `idVendor`/`idProduct` if needed):

```bash
SUBSYSTEM=="tty", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="27dd", GROUP="dialout", MODE="0666"
```

Then reload udev:

```bash
sudo udevadm control --reload-rules
```



## 📦 Project Layout

```
.
├── build/               # Compiled .bin
├── docs/                # WebSerial + Processing viewer (GitHub Pages root)
├── examples/I2C/MPU6050/
│   ├── main.c
│   ├── Makefile
│   ├── README.md
│   └── test_mpu.py      # Python preview script
├── src/                 # Firmware libraries (USB, I2C, system)
├── tools/               # Flash + setup scripts
└── venv/                # Optional Python environment
```



## 🌐 Live Visualization (GitHub Pages)

> WebSerial-enabled! No driver required. Works on Chromium-based browsers.

To preview motion data in real-time:

1. Host `docs/` using Python or GitHub Pages.
2. Open `index.html` in your browser.
3. Click **Connect Serial**.
4. Move the sensor — the airplane will reflect orientation changes!

Files:

* `index.html`: Main viewer with WebSerial and Processing.js
* `gyro_model.pde`: Airplane 3D sketch (Processing.js)
* `9.gif`, `11.gif`: Visual demos


## 🧪 Test via Serial

Send test data:

```bash
echo '{"gyro":{"x":100,"y":0,"z":0}}' > /dev/ttyACM1
```

Live monitor:

```bash
picocom /dev/ttyACM1 -b 115200
```

---
## ⚖️ Licensing

* **Firmware**: MIT License
* **USB stack**: [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) (by wagiminator)
* **WebSerial logic**: MPL 2.0 (MDN examples)
* **Processing.js**: GNU GPL v3

You are free to reuse and remix with attribution.


## 📸 Demo

![Demo](docs/9.gif)


## 🤝 Contributing

Pull requests and feedback are welcome! Feel free to fork and adapt.


## 🛠 Tools Used

* [SDCC Compiler](https://sdcc.sourceforge.net/)
* [chprog.py](https://github.com/UNTelectronics/chprog)
* [WebSerial API](https://developer.mozilla.org/en-US/docs/Web/API/Serial)
* [Processing.js](https://processingjs.org/)

<div>
    <h2>Contributors</h2>
    <ul>
        <li><a href="https://github.com/FeerFlores"><strong>FeerFlores</strong></a> – Original creator of the project.</li>
        <li><a href="https://github.com/Cesarbautista10">Cesar Bautista:</a> Primary maintainer and author of the software adaptation, WebSerial integration, and Processing visualization.</li>
        <li><a href="https://github.com/wagiminator"><strong>wagiminator</strong></a> – USB stack author.</li>
        <li><a href="https://github.com/AlbertoVillanuevaEsquivel">Alberto Villanueva:</a> – Hardware design and development.</li>
    </ul>
</div>
