const   ginp='weight.inp';
        gout='weight.out';
        oo=trunc(1e9)+1;

type    save=record g,v:longint;s:int64;end;

var     n,rma,rmi:longint;
        a:array[0..400010] of longint;
        dma,dmi:array[0..400010] of save;
        sum:int64;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
end;

procedure pma(i:longint);
begin
        while (rma>0) and (a[i]>=dma[rma].g) do dec(rma);
        inc(rma);dma[rma].v:=i;dma[rma].g:=a[i];
        dma[rma].s:=dma[rma-1].s+int64(a[i])*(i-dma[rma-1].v);
end;

procedure pmi(i:longint);
begin
        while (rmi>0) and (a[i]<=dmi[rmi].g) do dec(rmi);
        inc(rmi);dmi[rmi].v:=i;dmi[rmi].g:=a[i];
        dmi[rmi].s:=dmi[rmi-1].s+int64(a[i])*(i-dmi[rmi-1].v);
end;

procedure process;
var     i:longint;
begin
        rma:=1;dma[1].g:=0;
        rmi:=1;dmi[1].g:=oo;
        for i:=1 to n do
        begin
                pma(i);pmi(i);
                sum:=sum+dma[rma].s-dmi[rmi].s;
        end;
        write(sum);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.





