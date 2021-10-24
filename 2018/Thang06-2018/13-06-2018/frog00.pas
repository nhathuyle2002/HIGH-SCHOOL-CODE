const   ginp='frog.inp';
        gout='frog.out';

type    save=record g:int64;v:longint;end;

var     gi,go:text;
        m,n,k:longint;
        tv:save;
        la:array[0..1001] of longint;
        a,trace:array[0..1001,0..1001] of longint;
        f:array[0..1001,0..10001] of save;

procedure input;
var     i,j:longint;
begin
        readln(gi,m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

procedure build(id,l,r:longint);
var     mid:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        mid:=(l+r) shr 1;
        build(id*2,l,mid);
        build(id*2+1,mid+1,r);
end;

procedure update(id,i:longint);
begin
        if id=0 then exit;
        if f[i,id].g<tv.g then
        begin
                f[i,id]:=tv;
                update(id shr 1,i);
        end;
end;

procedure quece(id,l,r,d,c,i:longint);
var     mid:longint;
begin
        if (d>r) or (c<l) then exit;
        if (d<=l) and (r<=c) then
        begin
                if f[i,id].g>tv.g then tv:=f[i,id];
                exit;
        end;
        mid:=(l+r) shr 1;
        quece(id*2,l,mid,d,c,i);
        quece(id*2+1,mid+1,r,d,c,i);
end;

procedure process;
var     i,j,dem:longint;
        ou:array[0..1001] of longint;
        tm:int64;
begin
        build(1,1,n);
        for i:=1 to m do
                for j:=1 to n do
                begin
                        tv.g:=0;tv.v:=0;
                        quece(1,1,n,j-k,j+k,i-1);
                        trace[i,j]:=tv.v;
                        tv.v:=j;inc(tv.g,a[i,j]);
                        update(la[j],i);
                end;
        writeln(go,f[m,1].g);
        i:=m;j:=f[m,1].v;
        dem:=0;
        repeat
                inc(dem);ou[dem]:=j;
                j:=trace[i,j];
                dec(i);
        until i=0;
        for i:=dem downto 1 do writeln(go,ou[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
