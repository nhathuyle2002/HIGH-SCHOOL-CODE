const   ginp='lamp.inp';
        gout='lamp.out';

var     gi,go:text;
        n,m:longint;
        ans:int64;
        d:array[0..5001,0..5001] of boolean;
        dc:array[-1000001..1000001] of boolean;
        link,y:array[-1000001..1000001] of longint;
        head:array[0..1000001] of longint;

procedure process1;
var     i,j,k,t,dem1,dem2:longint;
begin
        fillchar(d,sizeof(d),false);
        for t:=1 to m do
        begin
                readln(gi,i,j);
                dem1:=0;dem2:=0;
                for k:=1 to n do
                        if (i<>k) and (j<>k) and (d[i,k]=false) and (d[j,k]=false) then inc(dem1)
                        else
                        if (i<>k) and (j<>k) and (d[i,k]=true) and (d[j,k]=true) then inc(dem2);
                if d[i,j]=false then
                begin
                        ans:=ans+dem2-dem1;
                        d[i,j]:=true;d[j,i]:=true;
                end
                else
                begin
                        ans:=ans-dem2+dem1;
                        d[i,j]:=false;d[j,i]:=false;
                end;
                writeln(go,ans);
        end;
end;

procedure ad(i,u,v:longint);
begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
end;

procedure process2;
var     t,i,dem1,dem2,u,v,tm:longint;
        d1,d2:array[0..1000001] of boolean;
begin
        fillchar(dc,sizeof(dc),true);
        for t:=1 to m do
        begin
                readln(gi,u,v);
                dem1:=0;dem2:=0;
                fillchar(d1,sizeof(d1),false);
                fillchar(d2,sizeof(d2),false);
                tm:=0;
                i:=head[u];
                while i<>0 do
                begin
                        if (dc[i]) then
                        begin
                                d1[y[i]]:=true;
                                if y[i]=v then tm:=i;
                        end;
                        i:=link[i];
                end;
                i:=head[v];
                while i<>0 do
                begin
                        if (dc[i]) then d2[y[i]]:=true;
                        i:=link[i];
                end;
                for i:=1 to n do
                        if (i<>u) and (i<>v) then
                        begin
                                if (d1[i]) and (d2[i]) then inc(dem1);
                                if (d1[i]=false) and (d2[i]=false) then inc(dem2);
                        end;
                if tm=0 then
                begin
                        ans:=ans-dem2+dem1;
                        ad(t,u,v);
                        ad(-t,v,u);
                end
                else
                begin
                        ans:=ans+dem2-dem1;
                        dc[tm]:=false;
                        dc[-tm]:=false;
                end;
                writeln(go,ans);
        end;
end;

procedure input;
var     i,dem:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        dem:=0;ans:=0;
        for i:=3 to n do
        begin
                dem:=dem+i-2;
                ans:=ans+dem;
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process2;
        output;
end.
