
---

# 🚀 FK743M2-IIT6 Development Board (STM32H743IIT6)

Профессиональная отладочная плата на базе микроконтроллера **STM32H743IITx**. Проект сконфигурирован для работы с высокоскоростной памятью SDRAM, USB-отладкой и базовой периферией.

---

## 💡 1. LED (Светодиод)
Базовый индикатор для проверки работоспособности (Heartbeat).

### 📍 Распиновка (Pinout)
| Pin | Signal | Mode | Label |
| :--- | :--- | :--- | :--- |
| **PH7** | GPIO_Output | Push-Pull, No pull | LED |

### ⚙️ Параметры CubeMX
* **GPIO output level**: Low
* **GPIO mode**: Output Push Pull
* **GPIO Pull-up/Pull-down**: No pull
* **Maximum output speed**: Low

---

## 🔌 2. USB VCP (Virtual COM Port)
Настройка USB в режиме Full Speed Device для эмуляции COM-порта (CDC).

### 📍 Распиновка (Pinout)
| Pin | Signal | Mode |
| :--- | :--- | :--- |
| **PA11** | USB_OTG_FS_DM | Device_Only |
| **PA12** | USB_OTG_FS_DP | Device_Only |

### ⚙️ Параметры CubeMX
* **Connectivity -> USB_OTG_FS**: Mode: `Device_Only`.
* **Middleware -> USB_DEVICE**:
    * **Class For FS IP**: `Communication Device Class (Virtual Port Com)`.
    * **Heap Size**: `0x200`.
    * **Stack Size**: `0x400`.

---

## 🧠 3. SDRAM — Winbond W9825G6KH
Внешняя память объемом 32 MB (256 Mbit), работающая через контроллер FMC на 16-битной шине данных.

### 📍 FMC Pin Mapping (AF12, Very High Speed)
\<details\>
\<summary\>Развернуть таблицу распиновки SDRAM\</summary\>

| Группа | STM32 Pins | Signal |
| :--- | :--- | :--- |
| **Control** | PH2, PH3, PH5, PF11, PG15, PG8 | CKE0, NE0, NWE, NRAS, NCAS, CLK |
| **Address** | PF0-PF5, PF12-PF15, PG0-PG2 | A0 - A12 |
| **Data** | PD14, PD15, PD0, PD1, PE7-PE15, PD8-PD10 | D0 - D15 |
| **Bank/Mask** | PG4, PG5 / PE0, PE1 | BA0, BA1 / NBL0, NBL1 |

\</details\>

### ⚙️ Параметры CubeMX (SDRAM Bank 1)
| Параметр | Значение |
| :--- | :--- |
| **Column Bits Number** | 9 bits |
| **Row Bits Number** | 13 bits |
| **Memory Data Width** | 16 bits |
| **Internal Banks Number** | 4 banks |
| **CAS Latency** | 3 cycles |
| **SDRAM Common Clock** | 2 HCLK Cycles |
| **Read Pipe Delay** | 1 cycle |

### ⏱ Тайминги FMC (в тактах)
Настроены согласно конфигурации `.ioc` для частоты FMC 200 MHz (SDCLK 100 MHz):
* **Load To Active Delay**: 5
* **Exit Self Refresh Delay**: 8
* **Self Refresh Time**: 4
* **Row Cycle Delay**: 6
* **Write Recovery Time**: 2
* **RP Delay / RCD Delay**: 2

---

## 🛡 4. Настройка MPU
Для корректной работы кэша H7 с SDRAM (особенно при использовании DMA) необходимо настроить MPU для региона `0xC0000000` (32MB).

```c
/* Region 1: SDRAM - Full Access, No Cache */
MPU_InitStruct.Enable = MPU_REGION_ENABLE;
MPU_InitStruct.BaseAddress = 0xC0000000;
MPU_InitStruct.Size = MPU_REGION_SIZE_32MB;
MPU_InitStruct.AccessPermission = MPU_REGION_FULL_ACCESS;
MPU_InitStruct.IsCacheable = MPU_ACCESS_NOT_CACHEABLE;
MPU_InitStruct.IsBufferable = MPU_ACCESS_NOT_BUFFERABLE;
HAL_MPU_ConfigRegion(&MPU_InitStruct);
```

---

## 🔗 Ссылки и ресурсы
* **Документация на плату**: [GitHub LuMorning602/STM32H743](https://github.com/LuMorning602/STM32H743)
* **Драйвер SDRAM**: [GitHub MaxESP/Stm32h743-SDRAM](https://github.com/MaxESP/Stm32h743-SDRAM-w9825g6kh-32MB-Driver)
* **Техническое описание MCU**: [STM32H743II на ST.com](https://www.st.com/en/microcontrollers-microprocessors/stm32h743ii.html)
* **Reference Manual**: [RM0433 (PDF)](https://www.st.com/resource/en/reference_manual/dm00314099.pdf)
* **IDE**: [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)

---
*Плата версия: 1.1 | Конфигурация: CubeMX 6.17.0 | Библиотеки: HAL H7 V1.13.0*