
# Location of URI, FILE_NAMES
API_URI = "https://brianw.bp:8088" #'https://test.bitpay.com'
ROOT_URL = "http://brianw.bp:4567" #'localhost:4567'
PEM_FILE_NAME = 'merchpem.pem'
LOG_FILE_NAME = 'log.txt'
LAST_LOG_FILE_NAME = 'last_log.json'

# Path
PEM_PATH = File.join File.dirname(__FILE__), '..', 'pem', PEM_FILE_NAME
LOG_PATH = File.join File.dirname(__FILE__), '..', 'logs', LOG_FILE_NAME
LAST_LOG_PATH = File.join File.dirname(__FILE__), '..', 'logs', LAST_LOG_FILE_NAME

# PEM_PATH = "./../pem/" + PEM_FILE_NAME
# LOG_PATH = "./../logs/" + LOG_FILE_NAME
# LAST_LOG_PATH = "./../logs/" + LAST_LOG_FILE_NAME
