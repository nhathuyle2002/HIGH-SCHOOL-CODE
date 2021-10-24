const   ginp='number.inp';
        gout='number.out';

var     gi,go:text;
        s1,s2:string;
        m,sb:longint;
        ou1:array[0..101] of string;
        ou2:array[0..101] of longint;

procedure xuat;
var     i:longint;
begin
        for i:=sb downto 1 do writeln(go,ou2[i],' ',ou1[i]);
        close(gi);close(go);
        halt;
end;

procedure try(s:string);
var     i,j,tm:longint;
        x:string;
begin
        if s=s1 then xuat;
        if length(s)<=1 then exit;
        inc(sb);
        for i:=1 to length(s)-1 do
        begin
                x:=s;ou2[sb]:=i;
                ou1[sb]:=copy(x,i,2);
                val(ou1[sb],tm);
                delete(x,i,2);insert(' ',x,i);
                for j:=0 to 9 do
                        if j mod m=tm mod m then
                        begin
                                x[i]:=chr(j+48);
                                try(x);
                        end;
        end;
        dec(sb);
end;

procedure main;
var     x:char;
        s:string;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,m);
        repeat read(gi,x) until x<>' ';
        s1:=x;readln(gi);read(gi,s2);
end;

begin
        main;
        try(s2);
end.


