Const   g1='square.out';
        g2='square0.out';
	g0='check.out';

Var	s1,s2:string;
	f1,f2,f0:text;
	cou:longint;

Begin
        Assign(f1,g1); Assign(f2,g2);
        Reset(f1); Reset(f2);
        assign(f0,g0); rewrite(f0);
	cou:=0;
	while not eof(f1) do
	begin
		inc(cou);
		readln(f1,s1); readln(f2,s2);
		if s1<>s2 then writeln(f0,cou);
	end;
        Close(f1); Close(f2); Close(f0);
End.
