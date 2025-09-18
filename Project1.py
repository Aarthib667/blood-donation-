import time
directions = ['North', 'East', 'South', 'West']
current_index = 0

print("=== Traffic Light Control System ===")
print("Modes Available:\n1. Auto\n2. Manual")
mode = input("Enter mode (auto/manual): ").lower()

if mode == 'auto':
    print("\n--- Auto Mode Activated ---")
    while True:
        current_direction = directions[current_index]
        print(f"\nGREEN Light ON for {current_direction} - 1 minute")
        time.sleep(55)  # Green for 55 seconds
        print("ORANGE Light ON - 5 seconds")
        time.sleep(5)  # Orange for 5 seconds
        print(f"RED Light ON for {current_direction}")
        
        current_index = (current_index + 1) % 4  

elif mode == 'manual':
    print("\n--- Manual Mode Activated ---")
    print("Choose direction (North, East, South, West)")
    while True:
        user_input = input("\nEnter direction (or type 'exit' to stop): ").capitalize()
        if user_input == 'Exit':
            print("Exiting Manual Mode...")
            break
        if user_input in directions:
            print(f"\nGREEN Light ON for {user_input} - Until next command")
            print("ORANGE Light ON - 5 seconds")
            time.sleep(5)
            print(f"RED Light ON for {user_input}")
        else:
            print("Invalid direction! Choose from North, East, South, West.")
else:
    print("Invalid mode selected! Please restart the program.")

