import random


word_list = ['тусур','матвей','нога','рука','голова','небо','волосы']


def get_word():
   rand_word = random.choice(word_list).upper()
   return rand_word


def display_hangman(tries):
   stages = [ # финальное состояние: голова, торс, обе руки, обе ноги
      '''-------- | |
      | O
      | \\|/
      | |
      | / \\
      -
      ''', 
      # голова, торс, обе руки, одна нога
      '''-------- | |
      | O
      | \\|/
      | |
      | /
      -
      ''', 
      # голова, торс, обе руки
      '''-------- | |
      | O
      | \\|/
      | |
      |
      -
      ''', 
      # голова, торс и одна рука
      '''-------- | |
      | O
      | \\|
      | |
      |
      -
      ''', 
      # голова и торс
      '''-------- | |
      | O
      | |
      | |
      |
      -
      ''', 
      # голова
      '''-------- | |
      | O
      |
      |
      |
      -
      ''', 
      # начальное состояние
      '''-------- | |
      |
      |
      |
      |
      -
      ''' 
   ]
   return stages[tries]


def play():
   rand_word = get_word()
   print('Давайте играть в угадайку слов!')
   word_completion = ['_'] * len(rand_word)
   guessed = False
   guessed_letters = []
   guessed_words = []
   tries = 6
   print(display_hangman(tries))
   print(*word_completion)
   while True:
      enter_word = input('Введите одну букву или слово целиком: ').upper()
      if not enter_word.isalpha():
         print('Не вводите иных символов кроме буквы или слова')
         continue
      if enter_word in guessed_letters:
         print(f'Буква {enter_word} уже была')
         continue
      if enter_word in guessed_words:
         print(f'Слово {enter_word} уже было')
         continue
      if len(enter_word) != 1 and len(enter_word) != len(rand_word):
         continue
      if enter_word in rand_word:
         if len(enter_word) == 1:
            guessed_letters += enter_word
            count = -1
            for c in rand_word:
               count += 1
               if c == enter_word:
                  word_completion[count] = enter_word
            print('Есть такая буква')
            print(*word_completion)
            if ''.join(word_completion) == rand_word:
               guessed = True
         else:
            guessed = True
      if enter_word not in rand_word:
         if len(enter_word) == 1:
            guessed_letters += enter_word
            tries -= 1
            print(f'Нет такой буквы, количество попыток: {tries}')
            print(display_hangman(tries))
            print(*word_completion)
         else:
            guessed_words.append(enter_word)
            tries -= 1
            print(f'Слово не верно, количество попыток: {tries}')
            print(display_hangman(tries))
            print(*word_completion)
         if guessed:
            print('Поздравляем, вы угадали слово! Вы победили!')
            return
         if tries == 0:
            print(f'Загаданным, оказалось слово - {rand_word}')
            return
         

print('Добро пожаловать!')
play()
contin_game = input('Хотите ещё сыграть, нажмите клавишу "д", не хотите нажмите "н": ')
while True:
   if contin_game.upper() == 'Д':
      play()
   if contin_game.upper() == 'Н':
      print('Всего хорошего, до новых встреч!')
      break
   else:
      contin_game = input('Для новой игры нажмите клавишу "д", для выхода из игры клавишу "н": ')
      continue