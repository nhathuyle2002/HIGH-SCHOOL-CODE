const   ginp='flip.inp';
        gout='flip.out';
        maxch=1 shl 16-1;

var     n,l,r:longint;
        f,q:array[0..maxch] of longint;
        d:array[1..16,0..4] of longint;

procedure create;
var     i:longint;
begin
        for i:=1 to 16 do
        begin
                if i>4 then
                begin
                        inc(d[i,0]);
                        d[i,d[i,0]]:=i-4;
                end;
                if i<13 then
                begin
                        inc(d[i,0]);
                        d[i,d[i,0]]:=i+4;
                end;
                if i and 3<>1 then
                begin
                        inc(d[i,0]);
                        d[i,d[i,0]]:=i-1;
                end;
                if i and 3<>0 then
                begin
                        inc(d[i,0]);
                        d[i,d[i,0]]:=i+1;
                end;
        end;
end;

procedure daob(i:longint; var x:longint);
var     t:longint;
begin
        t:=x shr (i-1) and 1;
        if t=0 then x:=x or (1 shl (i-1))
        else x:=x xor (1 shl (i-1));
end;

procedure bfs;
var     i,u,v,k:longint;
begin
        for i:=1 to maxch-1 do f[i]:=-1;
        l:=0; r:=2;
        q[1]:=0; q[2]:=maxch;
        repeat
                inc(l); u:=q[l];
                for i:=1 to 16 do
                begin
                        v:=u; daob(i,v);
                        for k:=1 to d[i,0] do daob(d[i,k],v);
                        if f[v]=-1 then
                        begin
                                inc(r); q[r]:=v;
                                f[v]:=f[u]+1;
                        end;
                end;
        until l>=r;
end;

procedure process;
var     i,t,k,ms:longint;
        a,b:string;
begin
        readln(t);
        for i:=1 to t do
        begin
                a:='';
                for k:=1 to 4 do
                begin
                        readln(b);
                        a:=a+b;
                end;
                ms:=0;
                for k:=1 to 16 do
                        if a[k]='H' then ms:=ms+1 shl (k-1);
                if f[ms]=-1 then writeln('Impossible')
                else writeln(f[ms]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        create;
        bfs;
        process;
        close(input);close(output);
end.
