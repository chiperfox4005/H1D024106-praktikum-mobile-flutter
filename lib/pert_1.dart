class Queue<T> {
  final List<T> _items = [];

  void enqueue(T element) {
    _items.add(element);
    print('Enqueued: $element');
  }

  T? pop() {
    if (isEmpty) {
      print('Antrian kosong! gabisa pop.');
      return null;
    }
    T removedItem = _items.removeAt(0);
    print('Popped: $removedItem');
    return removedItem;
  }

  T? peek() {
    if (isEmpty) return null;
    return _items.first;
  }

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  int get length => _items.length;

  void printQueue() {
    if (isEmpty) {
      print('Status Antrian: [Kosong]');
    } else {
      print('Status Antrian (Depan -> Belakang): ${_items.join(' -> ')}');
    }
  }

  @override
  String toString() => _items.toString();
}

void main() {
  print('SIMULASI CLASS QUEUE \n');

  Queue<String> antrianBank = Queue<String>();

  print('--- Menambahkan Data (Enqueue) ---');
  antrianBank.enqueue('Amba');
  antrianBank.enqueue('Rusdi');
  antrianBank.enqueue('Fuad');
  antrianBank.enqueue('Pasa');

  print('');
  antrianBank.printQueue();
  print('Jumlah antrian sekarang: ${antrianBank.length}');
  print('Orang terdepan sekarang: ${antrianBank.peek()}\n');

  print('Mengeluarkan Data (Pop)');
  antrianBank.pop();

  print('');
  antrianBank.printQueue();
  print('Jumlah antrian tersisa: ${antrianBank.length}\n');

  print('Menambah Antrian Baru ');
  antrianBank.enqueue('Ejra');
  antrianBank.printQueue();
  print('');

  print(' Menghabiskan Antrian ');
  antrianBank.pop();
  antrianBank.pop();
  antrianBank.pop();
  antrianBank.pop();

  print('');
  antrianBank.printQueue();
}