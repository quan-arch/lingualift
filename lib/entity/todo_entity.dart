class TodoEntity {
  final String text;
  final String character;
  final bool completed;

  const TodoEntity({
    required this.text,
    required this.character,
    required this.completed,
  });
}

const List<TodoEntity> todos = [
  TodoEntity(text: 'Write the verb in brackets in the correct form, present simple or present continuous, in each gap.', character: 'A', completed: true),
  TodoEntity(text: 'Write one word in each gap.', character: 'B', completed: false),
  TodoEntity(text: 'Write a verb from the box in the correct form, present simple or present continuous, in each gap. Use the words in brackets with the verb. Use contractions where possible. You can use the verbs more than once.', character: 'C', completed: false),
  TodoEntity(text: 'Circle the correct word or phrase.', character: 'D', completed: false),
  TodoEntity(text: 'Write a verb from the box in the correct form, present simple or present continuous, in each pair of sentences.', character: 'E', completed: false),
  TodoEntity(text: 'Each of the words or phrases in bold is incorrect. Rewrite them correctly.', character: 'F', completed: false),
  TodoEntity(text: 'Circle the correct word or phrase. If both are correct, circle both.', character: 'G', completed: false),
  TodoEntity(text: 'Write the verb in brackets in the correct form, present perfect simple or present perfect continuous. Use contractions where possible.', character: 'H', completed: false),
  TodoEntity(text: 'Write a word from the box in each gap. You can use each word more than once.', character: 'I', completed: false),
  TodoEntity(text: 'Write one word in each gap.', character: 'J', completed: false),
];
