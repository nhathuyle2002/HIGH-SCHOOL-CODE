const   ginp='bitstr.inp';
        gout='bitstr.out';

var     n,res:longint;
        a,b:array[0..100010] of longint;

procedure enter;
var     i:longint;
        s:ansistring;
begin
        read(s);
        n:=length(s);
        for i:=1 to n do b[i]:=ord(s[i])-48;
end;

procedure process;
var     i,j,cou:longint;
begin
        res:=n+1;
        a:=b; cou:=0;
        for i:=1 to n-3 do
                if a[i]=1 then
                begin
                        inc(cou);
                        for j:=i to i+3 do a[j]:=1-a[j];
                end;
        for i:=n-2 to n+1 do
                if a[i]=1 then break;
        if i=n+1 then res:=cou;
        a:=b; cou:=0;
        for i:=1 to n-3 do
                if a[i]=0 then
                begin
                        inc(cou);
                        for j:=i to i+3 do a[j]:=1-a[j];
                end;
        for i:=n-2 to n+1 do
                if a[i]=0 then break;
        if (i=n+1) and (cou<res) then res:=cou;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
