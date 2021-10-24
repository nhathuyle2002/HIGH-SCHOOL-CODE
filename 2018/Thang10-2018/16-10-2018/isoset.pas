Const   ginp='isoset.inp';
        gout='isoset.out';
        g9=362880;
        g10=3628800;

Var     cs:string[1];
        a,b:string[100];

Procedure Enter;
Var     i:longint;
        s:string[100];
Begin
        a:=''; b:='';
        readln(s);
        while s[1]=' ' do delete(s,1,1);
        while s[length(s)]=' ' do delete(s,length(s),1);
        if cs='S' then a:=s else
        begin
                while s[1]<>' ' do
                begin
                        a:=a+s[1];
                        delete(s,1,1);
                end;
                while s[1]=' ' do delete(s,1,1);
                b:=s;
        end;
End;

Procedure Process1;
Var     i:longint;
        da,db:array['0'..'9'] of longint;
Begin
        if length(a)<>length(b) then
        begin
                writeln('NO');
                exit;
        end;
        fillchar(da,sizeof(da),0);
        fillchar(db,sizeof(db),0);
        for i:=1 to length(a) do
        begin
                if da[a[i]]<>db[b[i]] then
                begin
                        writeln('NO');
                        exit;
                end;
                da[a[i]]:=i; db[b[i]]:=i;
        end;
        writeln('YES');
End;

Procedure Process2;
Var     i,cou,gt:longint;
        d:array['0'..'9'] of boolean;
Begin
        fillchar(d,sizeof(d),false);
        cou:=0;
        for i:=1 to length(a) do
                if not d[a[i]] then
                begin
                        inc(cou);
                        d[a[i]]:=true;
                end;
        gt:=1;
        for i:=1 to 10-cou do gt:=gt*i;
        writeln(g10 div gt-g9 div gt);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        repeat
                read(cs);
                if cs='' then break;
                Enter;
                if cs='V' then Process1 else Process2;
        until false;
        Close(input); Close(output);
End.
