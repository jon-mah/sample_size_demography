def generate_output(filename):
    with open(filename, 'w') as f:
        for i in range(1000):
            f.write(f"tsk_{i}\tpop1\n")

if __name__ == "__main__":
    output_filename = "sample_1000_pops.txt"
    generate_output(output_filename)
    print(f"Output generated to {output_filename}")
