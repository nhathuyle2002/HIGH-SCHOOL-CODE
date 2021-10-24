Const   ginp='clocks.inp';
        gout='clocks.out';
        n=9;

Var     k:longint;
        res:int64;
        a,b,d:array[0..10] of longint;
        e:array[0..10,0..4] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=a[i] div 3 mod 4;
        end;
        readln; readln(k);
        for i:=1 to k do
        begin
                for j:=1 to 4 do read(e[i,j]);
                read(e[i,0]); readln;
        end;
End;

Procedure try(i:longint; ww:int64);
var     j,ii:longint;
begin
        if i=k+1 then
        begin
                for ii:=1 to n do
                        if a[ii]<>b[ii] then exit;
                if (res=-1) or (res>ww) then res:=ww;
                exit;
        end;
        for j:=0 to 3 do
        begin
                for ii:=1 to 4 do b[e[i,ii]]:=(b[e[i,ii]]+j) mod 4;
                try(i+1,ww+int64(e[i,0])*j);
                for ii:=1 to 4 do b[e[i,ii]]:=(b[e[i,ii]]-j+4) mod 4;
        end;
end;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        res:=-1; try(1,0);
        write(res);
        Close(input); Close(output);
End.
