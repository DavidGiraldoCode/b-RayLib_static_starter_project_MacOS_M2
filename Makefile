# Makefile for C++ Raylib project
# Simple, and works with static libraylib.a

# === Compiler & flags ===
CXX = clang++
CXXFLAGS = -std=c++17 -Wall -Iinclude
LDFLAGS = -Llib -lraylib \
          -framework CoreVideo \
          -framework IOKit \
          -framework Cocoa \
          -framework GLUT \
          -framework OpenGL

# === Debug mode ===
ifdef DEBUG
    CXXFLAGS += -g -O0   # Include debug symbols, no optimization
    BUILD_DIR = build/debug
    TARGET = my_app_debug
else
    CXXFLAGS += -O2      # Release optimization
    BUILD_DIR = build/release
    TARGET = my_app
endif

# === Directories ===
SRC_DIR = src
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))

# === Default target ===
all: $(BUILD_DIR) $(TARGET)

# === Compile objects ===
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# === Link executable ===
$(TARGET): $(OBJS)
	$(CXX) $(OBJS) $(LDFLAGS) -o $@

# === Create build directory ===
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# === Clean ===
clean:
	rm -rf build my_app my_app_debug

# === Run the app easily ===
run: $(TARGET)
	./$(TARGET)

# === Debug build shortcut ===
debug:
	$(MAKE) DEBUG=1
