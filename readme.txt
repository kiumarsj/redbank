import configparser

config = configparser.ConfigParser()

config['Database'] = {'host': 'localhost',
                      'port': '5432',
                      'username': 'admin',
                      'password': 'password'}

with open('config.ini', 'w') as configfile:
    config.write(configfile)
