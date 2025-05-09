import serial
import json

# Abrir el puerto
port = '/dev/ttyACM1'
baudrate = 9600

try:
    ser = serial.Serial(port, baudrate, timeout=1)
    print(f"✅ Puerto {port} abierto a {baudrate} baudios")
except Exception as e:
    print(f"❌ Error al abrir el puerto: {e}")
    exit(1)

print("🔄 Esperando datos JSON del CH552...\n")

# Bucle de lectura
while True:
    try:
        line = ser.readline().decode('utf-8').strip()
        if line:
            try:
                data = json.loads(line)
                accel = data["accel"]
                gyro = data["gyro"]
                temp = data["temp"]

                print(f"Accel: x={accel['x']} y={accel['y']} z={accel['z']}")
                print(f" Gyro: x={gyro['x']} y={gyro['y']} z={gyro['z']}")
                print(f" Temp: {temp}\n")

            except json.JSONDecodeError:
                print(f"⚠️  Línea no es JSON válido: {line}")

    except KeyboardInterrupt:
        print("\n⏹️ Finalizando lectura.")
        break

ser.close()
