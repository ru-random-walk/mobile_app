String questionWord(int count) {
  int mod10 = count % 10;
  int mod100 = count % 100;
  
  if (mod10 == 1 && mod100 != 11) {
    return 'вопрос';
  } else if (mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14)) {
    return 'вопроса';
  } else {
    return 'вопросов';
  }
}