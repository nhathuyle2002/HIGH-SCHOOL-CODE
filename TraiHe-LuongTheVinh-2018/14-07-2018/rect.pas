const   ginp='rect.inp';
        gout='rect.out';
        oo=trunc(1e9);

var     m,n,l,r:longint;
        res:int64;
        h,d,ft,fs:array[0..500010] of longint;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i:longint;
begin
        r:=1;d[1]:=0;h[0]:=0;ft[0]:=0;
        for i:=1 to n do
        begin
                fs[i]:=n+1;
                while (r>0) and (h[i]<h[d[r]]) do
                begin
                        fs[d[r]]:=i;
                        dec(r);
                end;
                if h[i]=h[d[r]] then ft[i]:=ft[d[r]]
                else ft[i]:=d[r];
                inc(r);d[r]:=i;
        end;
        for i:=1 to n do
                res:=max(res,int64(h[i])*(fs[i]-ft[i]-1));
end;

procedure main;
var     i:longint;
begin
        readln(m,n);
        for i:=1 to n do read(h[i]);
        res:=0;
        process;
        for i:=1 to n do h[i]:=m-h[i];
        process;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.