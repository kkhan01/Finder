class Job {
  int _id;
  String _company;
  String _location;
  String _position;
  String _description;
  String _url;

  Job(this._company, this._location, this._position, this._description,
      this._url);

  Job.withId(this._id, this._company, this._location, this._position,
      this._description, this._url);

  int get id => _id;
  String get company => _company;
  String get location => _location;
  String get position => _position;
  String get description => _description;
  String get url => _url;

  set company(String newCompany) {
    this._company = newCompany;
  }

  set location(String newLocation) {
    this._location = newLocation;
  }

  set position(String newPosition) {
    this._position = newPosition;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set url(String newUrl) {
    this._url = newUrl;
  }

// Convert Job to Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['company'] = company;
    map['location'] = location;
    map['position'] = position;
    map['description'] = description;
    map['url'] = url;
    return map;
  }

// Convert Map to Job
  Job.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._company = map['company'];
    this._location = map['location'];
    this._position = map['position'];
    this._description = map['description'];
    this._url = map['url'];
  }
}
