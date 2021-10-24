const   ginp='oo.inp';
        gout='oo.out';

var     gi,go:text;
        n,m,maxd,minl,la,ra,lb,rb:longint;
        a,f,ma,mb:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,minl,maxd);
        for i:=1 to n do read(gi,a[i]);
end;

procedure push(i:longint);
begin
        while (la<=ra) and (a[i]>=a[ma[ra]]) do dec(ra);
        inc(ra);ma[ra]:=i;
        while (lb<=rb) and (a[i]<=a[mb[rb]]) do dec(rb);
        inc(rb);mb[rb]:=i;
end;

procedure pop(i:longint);
begin
        while (la<=ra) and (ma[la]<i) do inc(la);
        while (lb<=rb) and (mb[lb]<i) do inc(lb);
end;

procedure process;
var     i,j:longint;
begin
        la:=0;ra:=0;ma[0]:=0;
        lb:=0;rb:=0;mb[0]:=n+1;a[n+1]:=trunc(1e5);
        f[0]:=1;
        for i:=1 to n do
        begin
                push(i);
                for j:=f[i-1] to i do
                begin
                        pop(j);
                        if a[ma[la]]-a[mb[lb]]<=maxd then
                        begin
                                f[i]:=j;
                                break;
                        end;
                end;
        end;
end;

procedure output;
var     i:longint;
        ans:int64;
begin
        ans:=0;inc(minl);
        for i:=1 to n do
                if (i-f[i]+1>=minl) then
                        ans:=ans+i-f[i]-minl+2;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
