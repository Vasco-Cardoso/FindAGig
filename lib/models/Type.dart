class Type{

  int id;
  String name;

  Type(this.id, this.name);

  static List<Type> getTypes(){

    return <Type>[

      Type(1, ""),
      Type(2, "House"),
      Type(3, "Sales"),
      Type(4, "Security"),
      Type(5, "Eletronics"),
      Type(6, "Cleaning"),
      Type(7, "Other"),
    ];
  }
}