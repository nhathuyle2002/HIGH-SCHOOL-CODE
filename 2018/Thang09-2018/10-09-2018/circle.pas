const   ginp='circle.inp';
        gout='circle.out';
        maxn=100010;

var     n:longint;
        a,res:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

function min(x,y:longint):longint;
begin
        if x<y then min:=x else min:=y;
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
end;

function gt(x:longint):longint;
begin
        gt:=x mod n;
        if gt=0 then gt:=n;
end;

procedure dfs(u:longint);
var     v:longint;
begin
        d[u]:=false;
        v:=gt(u+3);
        if d[v] then
        begin
                res[v]:=res[u]+a[gt(u+2)]-a[gt(u+1)];
                dfs(v);
        end;
end;

procedure standard(var p:array of longint);
var     i,gmin:longint;
begin
        gmin:=0;
        for i:=1 to n do
                if d[i]=false then
                begin
                        p[i]:=res[i];
                        gmin:=min(gmin,p[i]);
                end else p[i]:=0;
        for i:=1 to n do
                if d[i]=false then p[i]:=p[i]-gmin+1;
end;

procedure answer(a1,a2,a3:array of longint);
var     i,v:longint;
        ok:boolean;
        pp:array[0..maxn] of longint;
begin
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if a1[i]>0 then
                begin
                        pp[i]:=a1[i];
                        d[a1[i]]:=false;
                end;
        for i:=n downto 1 do
                if d[i] then v:=i;
        for i:=1 to n do
                if a2[i]>0 then
                begin
                        if (a2[i]+v-1>n) or (not d[a2[i]+v-1]) then exit;
                        pp[i]:=a2[i]+v-1;
                        d[a2[i]+v-1]:=false;
                end;
        for i:=n downto 1 do
                if d[i] then v:=i;
        for i:=1 to n do
                if a3[i]>0 then
                begin
                        if (a3[i]+v-1>n) or (not d[a3[i]+v-1]) then exit;
                        pp[i]:=a3[i]+v-1;
                        d[a3[i]+v-1]:=false;
                end;
        if res[0]=0 then
        begin
                res:=pp;
                res[0]:=1;
        end else
        begin
                ok:=true;
                for i:=1 to n do
                        if res[i]<pp[i] then break else
                        if res[i]>pp[i] then
                        begin
                                ok:=false; break;
                        end;
                if not ok then res:=pp;
                res[0]:=1;
        end;
end;

procedure process1;
var     i,gmin:longint;
begin
        fillchar(d,sizeof(d),true);
        dfs(1);
        gmin:=0;
        standard(res);
        for i:=1 to n do write(res[i],' ');
end;

procedure process2;
var     i:longint;
        a1,a2,a3:array[0..maxn] of longint;
begin
        fillchar(d,sizeof(d),true);
        dfs(1); standard(a1);
        fillchar(d,sizeof(d),true);
        dfs(2); standard(a2);
        fillchar(d,sizeof(d),true);
        dfs(3); standard(a3);
        res[0]:=0;
        answer(a1,a2,a3); answer(a1,a3,a2);
        answer(a2,a1,a3); answer(a2,a3,a1);
        answer(a3,a1,a2); answer(a3,a2,a1);
        for i:=1 to n do write(res[i],' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        if n mod 3=0 then process2 else process1;
        close(input);close(output);
end.






