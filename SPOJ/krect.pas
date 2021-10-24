const   ginp='ss.inp';
        gout='ss.out';

var     m,n,k,cou1,cou2,res:longint;
        a:array[0..101] of string[101];
        d1,d2:array['A'..'Z'] of longint;

procedure enter;
var     i:longint;
begin
        readln(m,n,k);
        for i:=1 to m do readln(a[i]);
end;

procedure pop(i,j:longint);
begin
        dec(d1[a[i,j]]);
        if d1[a[i,j]]=0 then dec(cou1);
        dec(d2[a[i,j]]);
        if d2[a[i,j]]=0 then dec(cou2);
end;

procedure push1(i,j:longint);
begin
        inc(d1[a[i,j]]);
        if d1[a[i,j]]=1 then inc(cou1);
end;

procedure push2(i,j:longint);
begin
        inc(d2[a[i,j]]);
        if d2[a[i,j]]=1 then inc(cou2);
end;

procedure process;
var     i1,i2,i,j,j1,j2:longint;
        ok:boolean;
begin
        res:=0;
        for i1:=1 to m do
        for i2:=m downto i1 do
        begin
                cou1:=0; fillchar(d1,sizeof(d1),0);
                cou2:=0; fillchar(d2,sizeof(d2),0);
                ok:=false;
                j1:=0;j2:=0;
                for j:=1 to n do
                begin
                        if j>1 then
                                for i:=i1 to i2 do pop(i,j-1);
                        while (j1<=n) and (cou1<k) do
                        begin
                                inc(j1);
                                if j1<=n then
                                        for i:=i1 to i2 do push1(i,j1);
                        end;
                        if j1=n+1 then break;
                        while (j2<=n) and (cou2<=k) do
                        begin
                                inc(j2);
                                if j2<=n then
                                        for i:=i1 to i2 do push2(i,j2);
                        end;
                        if cou1=k then res:=res+j2-j1;
                        if cou1>=k then ok:=true;
                end;
                if not ok then break;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
