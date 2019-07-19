/*
 * Copyright (c) 2019 OFFIS Institute for Information Technology
 *                          Oldenburg, Germany
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * \file   append_update.c
 * \author Patrick Uven <patrick.uven@offis.de>
 * \brief  example program for the full online update
 */

#include "xil_io.h"

static uint32_t leds_val = 0x0f;

static void ledControl() {
	Xil_Out32(XPAR_UUU_0_UUU_0_GPIO_BASEADDR, leds_val);

	leds_val = (leds_val == 0x0f) ? 0xf0 : 0x0f;
}

int main(void) {
	for (;;) {
		ledControl();
	}
}
