import sys

def main():
    # !TODO: Add your code here
    filename = sys.argv[1]
    with open(filename, 'r') as f:
        lines = f.readlines()
    # problem 1
    sum = 0
    max_num = {
            "red": 12,
            "green": 13,
            "blue": 14,
            }
    for line in lines:
        line = line.strip()
        game, states = line.split(': ')
        game_id = int(game.split(' ')[1]) 
        satified = True
        for state in states.split('; '):
            pieces = state.split(', ')
            for piece in pieces:
                num, color = piece.split(' ')
                num = int(num)
                if num > max_num[color]:
                    satified = False
                    break   
            if not satified:
                break
        if satified:
            sum += game_id

    print(sum)
    # problem 2
    sum2 = 0
    for line in lines:
        colors = {
                "red": 0,
                "green": 0,
                "blue": 0,
                }
        line = line.strip()
        _, states = line.split(': ')

        for state in states.split('; '):
            pieces = state.split(', ')
            for piece in pieces:
                num, color = piece.split(' ')
                num = int(num)
                colors[color] = max(colors[color], num)

        sum2 += colors["red"] * colors["green"] * colors["blue"]
    print(sum2)

if __name__ == '__main__':
    main()
