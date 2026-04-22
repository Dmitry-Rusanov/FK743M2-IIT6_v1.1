################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../BSP/SDRAM/w9825g6kh.c 

OBJS += \
./BSP/SDRAM/w9825g6kh.o 

C_DEPS += \
./BSP/SDRAM/w9825g6kh.d 


# Each subdirectory must supply rules for building sources it contributes
BSP/SDRAM/%.o BSP/SDRAM/%.su BSP/SDRAM/%.cyclo: ../BSP/SDRAM/%.c BSP/SDRAM/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I../USB_DEVICE/App -I../USB_DEVICE/Target -I../Middlewares/ST/STM32_USB_Device_Library/Core/Inc -I../Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc -I"C:/Users/drusa/OneDrive/Документы/GitHub/FK743M2-IIT6_v1.1/BSP/SDRAM" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-BSP-2f-SDRAM

clean-BSP-2f-SDRAM:
	-$(RM) ./BSP/SDRAM/w9825g6kh.cyclo ./BSP/SDRAM/w9825g6kh.d ./BSP/SDRAM/w9825g6kh.o ./BSP/SDRAM/w9825g6kh.su

.PHONY: clean-BSP-2f-SDRAM

