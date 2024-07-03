import 'dart:io';

void main() {
  Library library = Library();

  library.addBook('Dart Programming', 'Chanankorn', '123456', 2);
  library.addBook('Flutter Development', 'Bukhoree', '789012', 2);
  library.addBook('Introduction to Algorithms', 'C. Lee', '567890', 1);
  library.addBook('Data Structures', 'D. Kim', '112233', 5);
  library.addBook('Machine Learning', 'E. Patel', '445566', 2);
  library.addBook('Artificial Intelligence', 'F. Martinez', '778899', 3);
  library.addBook('Cloud Computing', 'G. Lopez', '990011', 4);
  library.addBook('Cyber Security', 'H. Nguyen', '223344', 2);
  library.registerMember('Look in', 'M001');
  library.registerMember('Poom', 'M002');
  library.registerMember('Ram', 'M003');
  library.registerMember('Pond', 'M004');
  library.registerMember('Make', 'M005');
  library.registerMember('Rin', 'M006');

  while (true) {
    print('\nLibrary Management System');
    print('1. Add Book');
    print('2. Remove Book');
    print('3. Register Member');
    print('4. Borrow Book');
    print('5. Return Book');
    print('6. List Books');
    print('7. List Members');
    print('8. Exit');

    stdout.write('Choose an option: ');
    var choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      case 1:
        stdout.write('Enter book title: ');
        var title = stdin.readLineSync() ?? '';
        stdout.write('Enter book author: ');
        var author = stdin.readLineSync() ?? '';
        stdout.write('Enter book ISBN: ');
        var isbn = stdin.readLineSync() ?? '';
        stdout.write('Enter number of copies: ');
        var copies = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        library.addBook(title, author, isbn, copies);
        print('Book added successfully.');
        break;
      case 2:
        stdout.write('Enter book ISBN to remove: ');
        var isbn = stdin.readLineSync() ?? '';
        library.removeBook(isbn);
        print('Book removed successfully.');
        break;
      case 3:
        stdout.write('Enter member name: ');
        var name = stdin.readLineSync() ?? '';
        stdout.write('Enter member ID: ');
        var memberId = stdin.readLineSync() ?? '';
        library.registerMember(name, memberId);
        print('Member registered successfully.');
        break;
      case 4:
        stdout.write('Enter member ID: ');
        var memberId = stdin.readLineSync() ?? '';
        stdout.write('Enter book ISBN: ');
        var bookIsbn = stdin.readLineSync() ?? '';
        library.borrowBook(memberId, bookIsbn);
        print('Book borrowed successfully.');
        break;
      case 5:
        stdout.write('Enter member ID: ');
        var memberId = stdin.readLineSync() ?? '';
        stdout.write('Enter book ISBN: ');
        var bookIsbn = stdin.readLineSync() ?? '';
        library.returnBook(memberId, bookIsbn);
        print('Book returned successfully.');
        break;
      case 6:
        library.listBooks();
        break;
      case 7:
        library.listMembers();
        break;
      case 8:
        print('Exiting Library Management System.');
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}

class Book {
  String title;
  String author;
  String isbn;
  int copies;

  Book(this.title, this.author, this.isbn, this.copies);

  void borrowBook() {
    if (copies > 0) {
      copies--;
    } else {
      print('No copies left to borrow.');
    }
  }

  void returnBook() {
    copies++;
  }

  @override
  String toString() {
    return 'Book(title: $title, author: $author, isbn: $isbn, copies: $copies)';
  }
}

class Member {
  String name;
  String memberId;
  List<Book> borrowedBooks;

  Member(this.name, this.memberId) : borrowedBooks = [];

  void borrowBook(Book book) {
    book.borrowBook();
    borrowedBooks.add(book);
  }

  void returnBook(Book book) {
    book.returnBook();
    borrowedBooks.remove(book);
  }

  @override
  String toString() {
    return 'Member(name: $name, memberId: $memberId, borrowedBooks: ${borrowedBooks.map((b) => b.title).toList()})';
  }
}

class Library {
  List<Book> books;
  List<Member> members;

  Library()
      : books = [],
        members = [];

  void addBook(String title, String author, String isbn, int copies) {
    Book newBook = Book(title, author, isbn, copies);
    books.add(newBook);
  }

  void removeBook(String isbn) {
    Book? bookToRemove = findBookByIsbn(isbn);
    if (bookToRemove != null) {
      books.remove(bookToRemove);
    } else {
      print('Book with ISBN $isbn not found.');
    }
  }

  void registerMember(String name, String memberId) {
    Member newMember = Member(name, memberId);
    members.add(newMember);
  }

  Member? findMemberById(String memberId) {
    try {
      return members.firstWhere((m) => m.memberId == memberId);
    } catch (e) {
      return null;
    }
  }

  Book? findBookByIsbn(String isbn) {
    try {
      return books.firstWhere((b) => b.isbn == isbn);
    } catch (e) {
      return null;
    }
  }

  void borrowBook(String memberId, String isbn) {
    Member? member = findMemberById(memberId);
    Book? book = findBookByIsbn(isbn);
    if (member != null && book != null) {
      member.borrowBook(book);
    } else {
      print('Member or Book not found.');
    }
  }

  void returnBook(String memberId, String isbn) {
    Member? member = findMemberById(memberId);
    Book? book = findBookByIsbn(isbn);
    if (member != null && book != null) {
      member.returnBook(book);
    } else {
      print('Member or Book not found.');
    }
  }

  void listBooks() {
    print('Library Books:');
    books.forEach((book) => print(book));
  }

  void listMembers() {
    print('Library Members:');
    members.forEach((member) => print(member));
  }
}
