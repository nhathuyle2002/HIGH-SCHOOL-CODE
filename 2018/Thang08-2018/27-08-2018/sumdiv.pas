const   ginp='sumdiv.inp';
        gout='sumdiv.out';
        maxg=10000000;

var     n,q:longint;
        a:array[0..100001] of longint;
        s:array[0..100001] of int64;
        d:array[0..maxg] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(n,q);
        for i:=1 to n do read(a[i]);
        readln;
        fillchar(d,sizeof(d),0);
        for i:=2 to maxg do
                if d[i]=0 then
                begin
                        d[i]:=i;
                        for j:=i to maxg div i do
                                if d[i*j]=0 then d[i*j]:=i;
                end;
end;

procedure process;
var     i,l,r:longint;
begin
        for i:=1 to n do
                s[i]:=s[i-1]+d[a[i]]+1;
        for i:=1 to q do
        begin
                readln(l,r);
                writeln(s[r]-s[l-1]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
