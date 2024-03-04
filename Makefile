MAKEFLAGS += --no-print-directory
CPUS?=$(shell getconf _NPROCESSORS_ONLN || echo 1)

CC = g++-12
MARCH_NATIVE = ON
BUILD_DIR = build

.PHONY: all clean init-submodules update-submodules $(BENCHMARKS)

all: $(BUILD_DIR)
	@cd $(BUILD_DIR) && \
	cmake --build . --config Release --parallel $(CPUS)

$(BUILD_DIR):
	@conan install . -of=$(BUILD_DIR) -b=missing
	@cd $(BUILD_DIR) && \
	cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_CXX_COMPILER=$(CC) -DCMAKE_BUILD_TYPE=Release -DOPTIMIZE_FOR_NATIVE=${MARCH_NATIVE}
clean:
	@rm -rf $(BUILD_DIR)
