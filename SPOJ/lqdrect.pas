const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n:longint;
        a:array[0..1333,0..333] of longint;
        save:array[0..1 shl 16-1] of longint;
        res:int64;

procedure input;
var     i,j,k:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        while m and 15<>0 do inc(m);
        i:=1;
        while i<=m do
        begin
                for j:=1 to n do
                        for k:=i+1 to i+15 do
                                a[i,j]:=a[i,j]<<1+a[k,j];
                inc(i,16);
        end;
        for i:=1 to 1 shl 16-1 do
                for j:=0 to 15 do
                        if (i>>j) and 1=1 then inc(save[i]);
end;

procedure process;
var     i,j,k,cou:longint;
begin
        res:=0;
        for j:=1 to n-1 do
                for k:=j+1 to n do
                begin
                        cou:=0;i:=1;
                        while i<=m do
                        begin
                                cou:=cou+save[a[i,j] and a[i,k]];
                                inc(i,16);
                        end;
                        res:=res+cou*(cou-1) div 2;
                end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
