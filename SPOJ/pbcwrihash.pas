const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9)+7;
        base=5732107;

var     gi,go:text;
        n,m,res:longint;
        a,b:ansistring;
        ms:array['A'..'z'] of int64;
        sum:int64;
        f:array[0..3000100] of int64;

procedure create;
var     i:char;
        tm:int64;
begin
        tm:=base;
        for i:='A' to 'z' do
        begin
                tm:=(tm*base+random(100)+1) mod kk;
                ms[i]:=tm;
        end;
end;

procedure main;
var     i:longint;
begin
        readln(gi,n,m);
        readln(gi,a);
        for i:=1 to n do sum:=(sum+ms[a[i]]) mod kk;
        readln(gi,b);
        for i:=1 to m do f[i]:=(f[i-1]+ms[b[i]]) mod kk;
        res:=0;
        for i:=n to m do
                if (f[i]-f[i-n]+kk) mod kk=sum then inc(res);
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        create;
        main;
        close(gi);close(go);
end.
