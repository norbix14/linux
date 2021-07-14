#!usr/bin/env python

import sys
from random import randint

######################################################################

def data_gen():
  DEFAULT_TIMES = 20
  DEFAULT_FORMAT = 'txt'
  special = '¡!$%&¿?-_@'
  alpha = 'abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPWRSTUVWXYZ'
  nums = '1234567890'
  chars = [special, alpha, nums]
  data_format = ''
  times = 0
  data = ''

  cli_args = sys.argv[1:]

  if (len(cli_args) > 0):
    try:
      arg1 = int(cli_args[0])
      if not type(arg1) is int:
        raise ValueError('Value must be an integer')
      times = arg1
    except IndexError:
      times = DEFAULT_TIMES
    except ValueError:
      times = DEFAULT_TIMES
    try:
      arg2 = str(cli_args[1])
      data_format = 'json' if arg2 == 'json' else 'txt'
    except IndexError:
      data_format = DEFAULT_FORMAT
  else:
    times = DEFAULT_TIMES
    data_format = DEFAULT_FORMAT

  def gen_value(symbols):
    value, charset = '', ''
    for i in range(15):
      charset = symbols[randint(0, len(symbols) - 1)]
      value += charset[randint(0, len(charset) - 1)]
    return value

  def gen_key(letters):
    key = ''
    for i in range(5):
      key += letters[randint(0, len(letters) - 1)]
    return key

  def group_data(letters, symbols, rounds):
    dict_keys, dict_values = [], []
    for i in range(int(rounds)):
      dict_keys.append(gen_key(letters))
      dict_values.append(gen_value(symbols))
    return [dict_keys, dict_values]

  if (data_format == 'json'):
    [key, value] = group_data(alpha, chars, times)
    for i in range(len(key)):
      data += f'"{key[i]}":"{value[i]}",'
  else:
    [key, value] = group_data(alpha, chars, times)
    for i in range(len(key)):
      data += f'{key[i]}={value[i]}\n'

  return data

print(data_gen())
