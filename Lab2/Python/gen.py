def all_numbers():
    num_list = [i for i in range(pow(2, 12))]
    return num_list

def get_sign_magnitude(twos_binary):
    sign = twos_binary >> 11
    mag = twos_binary & (pow(2, 11) - 1)
    if sign:
        if (mag == 0):
            mag = pow(2, 11) - 1
        else:
            mag = ~mag + 1
    
    mag &= 0b0111_1111_1111

    return sign, mag

def get_exp_significand(mag):
    zero_count = 0
    for i in reversed(range(4, 11)):
        bit = 1 & (mag >> i)
        if not bit:
            zero_count += 1
        else:
            break

    four_bits = mag >> 7 - zero_count
    significand = four_bits
    exp = 7 - zero_count

    # Check for rounding bit
    if zero_count != 7:
        rounding_bit = (mag >> 6 - zero_count) & 1
        if rounding_bit:
            # Largest mag => largest representation
            if mag == pow(2, 11) - 1:
                significand = 15
                exp = 7
            # Overflow => shift, increase exp
            elif four_bits == 15:
                significand = 8
                # Avoid exponent overflow
                if exp != 7:
                    exp += 1
            # Round up
            else:
                significand = four_bits + 1   
    
    return exp, significand

def to_float(binary):
    sign, mag = get_sign_magnitude(binary)
    exp, significand = get_exp_significand(mag)
    
    sign_str = bin(sign)[2:]
    significand_str = f'{bin(significand)[2:]:0>4}'
    exp_str = f'{bin(exp)[2:]:0>3}'
    return {'sign': sign_str, 'sig': significand_str, 'exp': exp_str}

def write_all(binary_list, filename):
    signs = []
    sigs = []
    exps = []
    for binary in binary_list:
        float_dict = to_float(binary)
        signs.append(float_dict['sign'])
        sigs.append(float_dict['sig'])
        exps.append(float_dict['exp'])

    line_split = lambda x: '\n'.join(x)
    binary_list = [bin(b)[2:0] for b in binary_list]

    inputs = line_split(binary_list)
    signs = line_split(signs)
    sigs = line_split(sigs)
    exps = line_split(exps)
    
    with open(filename, 'w+') as f:
        f.write(inputs)
        f.write('\n')
        f.write(signs)
        f.write('\n')
        f.write(sigs)
        f.write('\n')
        f.write(exps)

if __name__ == '__main__':
    print('Begin generating tests')
    binary_list = all_numbers()
    write_all(binary_list, 'test.code')