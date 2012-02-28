from docutils.parsers.rst import directives
from sphinx.util.compat import Directive

import os
import shlex
import subprocess
import tikz

class GitLogDirective(Directive):
    has_content = True
    required_arguments = 0
    optional_arguments = 0
    final_argument_whitespace = True
    option_spec = {'git-dir':directives.unchanged}

    def run(self):
        git_log_script = os.path.join(os.getcwd(), 'tools', 'gitlog2tikz.sh')
        log_cmd = [git_log_script]
        if self.content:
            log_cmd.extend(shlex.split((u' '.join(self.content)).encode('ascii')))

        env = {}
        env.update(os.environ)

        git_dir = self.options.get('git-dir', None)
        if git_dir:
            env['GIT_DIR'] = git_dir
        
        tikz_generator = subprocess.Popen(log_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
        (tikz_data, err) = tikz_generator.communicate()
        if 0 != tikz_generator.returncode:
            raise RuntimeError(err)

        print(err)
        node = tikz.tikz()
        node['caption'] = ''
        node['tikz'] = tikz_data
        node['libs'] = 'calc'
        node['stringsubst'] = False

        return [node]

def setup(app):
    app.add_directive('gitlog', GitLogDirective)
