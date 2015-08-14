
# Location of URI, FILE_NAMES
API_URI = #"https://yourname.bp:8088" #'https://test.bitpay.com'
ROOT_URL = #"http://yourname.bp:4567" #'localhost:4567'
PEM_FILE_NAME = #'randomlygeneratedpem.pem'
LOG_FILE_NAME = 'log.txt' #'log.txt'
LAST_LOG_FILE_NAME = 'last_log.json' #'last_log.txt'

# Path
PEM_PATH = File.join File.dirname(__FILE__), '..', 'pem', PEM_FILE_NAME
LOG_PATH = File.join File.dirname(__FILE__), '..', 'logs', LOG_FILE_NAME
LAST_LOG_PATH = File.join File.dirname(__FILE__), '..', 'logs', LAST_LOG_FILE_NAME
