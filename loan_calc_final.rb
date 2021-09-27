system "clear"
LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('loan_calc.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def valid_choice?(choice)
  choice == 'n' || choice.downcase == 'n' ||
    choice == 'y' || choice.downcase == 'y'
end

def int_month_calc(apr)
  ((apr.to_f / 100) / 12).round(4)
end

def calc_monthly_payment(amount, int_month, dur_month)
  if int_month == 0.0
    amount.to_i / dur_month
  else
    amount.to_i * (int_month / (1 - (1 + int_month)**(-dur_month)))
  end
end

def get_name
  name = ''

  loop do
    prompt(messages("welcome", LANGUAGE))
    name = gets.chomp
    sleep(1)
    if name.empty?()
      prompt(messages("valid_name", LANGUAGE))
    else
      break
    end
  end
  name
end

def get_amount
  amount = ''
  loop do
    prompt(messages("amount", LANGUAGE))
    amount = gets.chomp
    break if valid_number?(amount) && number_greater_than_zero?(amount)
    prompt(messages("valid_number", LANGUAGE))
  end
  amount
end

def number_greater_than_zero?(number)
  number.to_i > 0 || number.to_f > 0
end

def get_loan_duration_years(duration)
  loop do
    prompt(messages("duration", LANGUAGE))
    duration = gets.chomp
    break if valid_number?(duration) && number_greater_than_zero?(duration)
    prompt(messages("valid_number", LANGUAGE))
  end
  duration
end

def display_loan_dur_months(dur_month)
  prompt(messages("duration_months", LANGUAGE))
  prompt dur_month.to_s
end

def get_apr(apr)
  loop do
    prompt(messages("apr", LANGUAGE))
    apr = gets.chomp
    break if (valid_number?(apr)) && ((apr.to_i >= 0) || (apr.to_f >= 0))
    prompt(messages("valid_number", LANGUAGE))
  end
  apr
end

def display_month_int(int_month)
  prompt(messages("apr_monthly", LANGUAGE))
  prompt int_month.to_s
end

def display_monthly_payment(monthly_payment_round)
  prompt(messages("monthly_repayment", LANGUAGE))
  sleep(1)
  prompt "£#{monthly_payment_round}"
end

def get_calc_again
  choice = ''
  loop do
    prompt(messages("go_again", LANGUAGE))
    choice = gets.chomp
    if valid_choice?(choice)
      break
    else
      prompt(messages("valid_choice", LANGUAGE))
    end
  end
  choice
end

def calc_again?(choice)
    choice.downcase == 'y'
end

loop do
  name = ''
  get_name
  sleep(1)

  amount = get_amount

  sleep(1)

  duration = ''
  year_dur = get_loan_duration_years(duration).to_f
  dur_month = year_dur * 12

  sleep(1)

  display_loan_dur_months(dur_month)

  apr = ''
  apr = get_apr(apr)
  int_month = int_month_calc(apr)

  sleep(1)

  display_month_int(int_month)
  monthly_payment_round =
    calc_monthly_payment(amount, int_month, dur_month).round(2)

  sleep(1)
  display_monthly_payment(monthly_payment_round)

  sleep(1)
  choice = get_calc_again
  break unless calc_again?(choice)
end

prompt(messages("thank_you", LANGUAGE))
