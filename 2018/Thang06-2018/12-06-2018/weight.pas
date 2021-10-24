const   ginp='weight.inp';
        gout='weight.out';
        maxn=1000010;
        oo=trunc(1e9);

type    deque=record v,g:longint;s:int64;end;

var     gi,go:text;
        n,rmi,rma:longint;
        a:array[0..maxn] of longint;
        ma,mi:array[0..maxn] of deque;
        res:int64;

procedure push(i:longint);
begin
        while (a[i]>=ma[rma].g) and (rma>0) do dec(rma);
        inc(rma);ma[rma].v:=i;ma[rma].g:=a[i];
        ma[rma].s:=(ma[rma].v-ma[rma-1].v)*int64(a[i])+ma[rma-1].s;

        while (a[i]<=mi[rmi].g) and (rmi>0) do dec(rmi);
        inc(rmi);mi[rmi].v:=i;mi[rmi].g:=a[i];
        mi[rmi].s:=(mi[rmi].v-mi[rmi-1].v)*int64(a[i])+mi[rmi-1].s;
end;

procedure main;
var     i:longint;
begin
        ma[0].g:=oo;mi[0].g:=-oo;
        res:=0;
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                push(i);
                res:=res+ma[rma].s-mi[rmi].s;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
