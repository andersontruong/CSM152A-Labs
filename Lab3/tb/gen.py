for i in range(60):
    num = str(bin(i))[2:]
    num = "0"*(6 - len(num)) + num
    print("\tbin <= 'b" + str(num) + "; // " + str(i) + "\n\t#10;\n\t$display(\"10s: %b\", out_dec10);\n\t$display(\"1s: %b\",out_dec1);")