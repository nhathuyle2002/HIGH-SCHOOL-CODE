const   ginp='papers.inp';
        gout='papers.out';
        kk=round(1e9)+7;

var     a,b:int64;
        n,m:int64;

procedure enter;
var     i,x:longint;
begin
        readln(m,n);
        for i:=1 to n do
        begin
                read(x);
                m:=m-x+1;
        end;
end;

function pow(k:longint):int64;
var     t:int64;
begin
        if k=0 then exit(1);
        t:=pow(k shr 1);
        pow:=(t*t) mod kk;
        if k and 1=1 then pow:=(pow*b) mod kk;
end;

procedure process;
var     i:longint;
begin
        if n>m then
        begin
                write(0);
                exit;
        end;
        a:=1;
        for i:=m-n+1 to m-1 do a:=(a*i) mod kk;
        b:=1;
        for i:=2 to n-1 do b:=(b*i) mod kk;
        b:=pow(kk-2);
        write(a*b mod kk);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
