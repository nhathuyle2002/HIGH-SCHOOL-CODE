Const   ginp='lrgame.inp';
        gout='lrgame.out';

Var     n:longint;
        a,b,res:ansistring;

Procedure Enter;
Begin
        readln(a);
        read(b);
        n:=length(a);
End;

Function Cmp1(x,y:ansistring):boolean;
Var     i:longint;
Begin
        for i:=1 to length(x) do
                if x[i]>y[i] then exit(true) else
                if x[i]<y[i] then exit(false);
        exit(true);
End;

Function Cmp2(x,y:ansistring):boolean;
Var     i:longint;
Begin
        for i:=1 to length(x) do
                if x[i]>y[i] then exit(true) else
                if x[i]<y[i] then exit(false);
        exit(false);
End;

Procedure Try(ii:longint; x,y:ansistring);
Var     i:longint;
        z,zz:ansistring;
Begin
        if (x<>'') and cmp2(copy(b,1,length(x)),x) then exit;
        if (res<>'') and cmp2(x,copy(res,1,length(x))) then exit;
        z:=x+y;
        if cmp1(z,b) then
        begin
                if (res='') or (cmp2(res,z)) then res:=z;
        end;
        for i:=ii-1 downto 1 do
        begin
                z:=x+y[i];
                zz:=y;
                delete(zz,i,1);
                try(i,z,zz);
        end;
End;

Procedure Process;
Begin
        res:='';
        try(n+1,'',a);
        if res='' then write(-1) else write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
