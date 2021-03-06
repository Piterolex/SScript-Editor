(* TCodeScanner.ParseNamespace *)
Procedure TCodeScanner.ParseNamespace;
Var Name                    : String;
    Deep                    : int16;
    Namespace, PrevNamespace: TNamespace;
Begin
 With Parser do
 Begin
  Name := read_ident;

  Namespace := findNamespace(Name);

  if (Namespace = nil) Then // new namespace
  Begin
   Namespace := TNamespace.Create(self, next(-1), getCurrentRange, Name);
   NamespaceList.Add(Namespace);
  End Else
  Begin
   AddIdentifier(Namespace, Parser.next(-1)); // add identifier reference
  End;

  PrevNamespace    := CurrentNamespace;
  CurrentNamespace := Namespace;

  Deep := getCurrentDeep;
  Repeat
   ParseToken;
  Until (getCurrentDeep = Deep);

  CurrentNamespace := PrevNamespace;
 End;
End;
