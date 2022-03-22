List _nulls = [null, '', 'null', 0, {}, [], "Null"];
List _justNull = [null, '', 'null', {}, [], "Null"];

bool isNull(dynamic list) {
  if (_nulls.contains(list)) {
    return true;
  } else {
    return false;
  }
}

bool nulls(dynamic data) {
  if (_justNull.contains(data)) {
    return true;
  } else {
    return false;
  }
}
