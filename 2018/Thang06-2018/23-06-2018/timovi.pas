const   ginp='timovi.inp';
        gout='timovi.out';

var     gi,go:text;
        n,i:longint;
        tm,sum,m,k:int64;
        f:array[0..400000] of int64;

procedure main;
begin
        read(gi,n,k,m);
        tm:=m div k;
        sum:=(tm div (2*n-2))*k;
        for i:=1 to 2*n-2 do f[i]:=sum;
        for i:=1 to tm mod (2*n-2) do f[i]:=f[i]+k;
        tm:=(tm+1) mod (2*n-2);
        if tm=0 then tm:=2*n-2;
        if m mod k>0 then f[tm]:=f[tm]+m mod k;
        for i:=2 to n-1 do f[i]:=f[i]+f[2*n-i];
        for i:=1 to n do write(go,f[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.